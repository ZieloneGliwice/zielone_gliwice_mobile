import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui' as ui;

import '../add_tree/add_tree_page.dart';
import '../all_trees/all_trees_page.dart';
import '../analytics/analytics.dart';
import '../model/errors.dart';
import '../model/my_tree.dart';
import '../model/my_trees.dart';
import '../model/signed_user.dart';
import '../my_tree_details/my_tree_details_page.dart';
import '../network/api_dio.dart';
import '../network/my_trees_provider.dart';
import '../schools_selection/schools_selection_page.dart';
import '../services/photos_service.dart';
import '../ui/activity_indicator.dart';
import '../ui/bottom_bar.dart';
import '../ui/date.dart';
import '../ui/dimen.dart';
import '../ui/error_view.dart';
import '../ui/gray_app_bar.dart';
import '../ui/no_data_view.dart';
import '../ui/styles.dart';
import '../ui/white_app_bar.dart';
import '../utils/session_controller.dart';
import '../utils/session_storage.dart';

class AllTreesPage extends GetView<AllTreesController> {
  const AllTreesPage({super.key});

  static const String path = '/all_trees_page';

  @override
  Widget build(BuildContext context) {
    Analytics.visitedScreen(AllTreesPage.path);
    return Scaffold(
      appBar: GrayAppBar(
        title: Text('all_trees_title'.tr),
      ),
      backgroundColor: ApplicationColors.background,
      body: Stack(
        children: [
          controller.obx(
            (MyTrees? myTrees) {
              if (myTrees?.trees?.isNotEmpty ?? false) {
                return _allTrees(myTrees!.trees!);
              } else {
                return _errorView(CommonError().identifier);
              }
            },
            onLoading: const ActivityIndicator(),
            onError: (String? error) => _errorView(error),
          ),
        ],
      ),
    );
  }

  Widget _errorView(String? error) {
    Analytics.visitedErrorScreen(AllTreesPage.path);
    final ZGError zgError = ZGError.from(error);

    return ErrorView.from(zgError, controller.getTrees);
  }

  Widget _allTrees(List<MyTree> trees) {
    Analytics.visitedScreen(AllTreesPage.path);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                child: Text.rich(
                  TextSpan(
                    style: ApplicationTextStyles.descriptionTextStyle,
                    children: <TextSpan>[
                      TextSpan(
                          text: '${trees.length} ',
                          style: ApplicationTextStyles.allTreesBoldTextStyle),
                      TextSpan(
                          text: 'registred_trees'.tr,
                          style: ApplicationTextStyles.allTreesTextStyle),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: Dimen.marginSmall, bottom: Dimen.marginNormal),
              child: ClipRRect(
                clipBehavior: Clip.hardEdge,
                borderRadius: const BorderRadius.all(Radius.circular(14)),
                child: SizedBox(
                  height: 500,
                  child: GoogleMap(
                    myLocationButtonEnabled: false,
                    mapToolbarEnabled: false,
                    zoomControlsEnabled: false,
                    initialCameraPosition: CameraPosition(
                        target: LatLng(double.parse(trees[11].lat!),
                            double.parse(trees[11].lon!)),
                        zoom: 14),
                    markers: controller.markers,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AllTreesController extends SessionController with StateMixin<MyTrees> {
  AllTreesController(this._myTreesProvider, SessionStorage sessionStorage,
      PhotosService photosService)
      : super(sessionStorage, photosService);
  final MyTreesProvider _myTreesProvider;

  Set<Marker> markers = <Marker>{};
  late LatLng startLocation;

  MyTrees? myTrees;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<void> getData() async {
    await getTrees();
  }

  //Na razie tylko moje drzewa z bazy danych
  Future<void> getTrees() async {
    change(null, status: RxStatus.loading());

    try {
      myTrees = await _myTreesProvider.getTrees();
      if (myTrees?.trees?.isNotEmpty ?? false) {
        createLocationMarkers(myTrees!.trees);
        change(myTrees, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.empty());
      }
    } on UnauthorizedException catch (_) {
      unauthorized();
    } on NoInternetConnectionException catch (_) {
      handleError(ConnectionError());
    } catch (_) {
      handleError(CommonError());
    }
  }

  void handleError(ZGError error) {
    change(null, status: RxStatus.error(error.identifier));
  }

  void viewDetails(MyTree myTree) {
    Analytics.buttonPressed('Tree details');
    Get.toNamed(MyTreeDetailsPage.path, arguments: myTree);
  }

  Future<void> createLocationMarkers(List<MyTree>? trees) async {
    for (int i = 0; i < trees!.length; i++) {
      final Marker marker = Marker(
        markerId: MarkerId(i.toString()),
        position:
            LatLng(double.parse(trees[i].lat!), double.parse(trees[i].lon!)),
        icon: await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(10, 10)),
            'assets/images/map_marker.png'),
        onTap: () => showInfo(trees[i]),
      );
      markers.add(marker);
    }
  }

  void showInfo(MyTree tree) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      context: Get.context!,
      builder: (BuildContext context) {
        return SizedBox(
          height: 380,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.close,
                      size: 32,
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    tree.treeThumbnailUrl() ?? '',
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return const ActivityIndicator();
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    const SizedBox(width: 10),
                    Text(
                      tree.species?.capitalize ?? '',
                      style: ApplicationTextStyles.bodyTextStyle,
                    ),
                    const Spacer(),
                    Date(dateString: tree.formattedTimeStamp()),
                    const SizedBox(width: 10),
                  ],
                ),
                const Spacer(),
                seeDetailsButton(tree),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget seeDetailsButton(MyTree tree) {
    return ElevatedButton(
      onPressed: () => viewDetails(tree),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        backgroundColor: ApplicationColors.green,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
      ),
      child: Text("see_details".tr),
    );
  }
}