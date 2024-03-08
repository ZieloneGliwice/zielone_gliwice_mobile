import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../analytics/analytics.dart';
import '../model/errors.dart';
import '../model/my_tree.dart';
import '../model/my_trees.dart';
import '../network/all_trees_provider.dart';
import '../network/api_dio.dart';
import '../services/photos_service.dart';
import '../tree_details/tree_details_page.dart';
import '../ui/activity_indicator.dart';
import '../ui/date.dart';
import '../ui/dimen.dart';
import '../ui/error_view.dart';
import '../ui/gray_app_bar.dart';
import '../ui/primary_button.dart';

import '../ui/styles.dart';
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
                    initialCameraPosition: const CameraPosition(
                        target: LatLng(50.294216, 18.664531), zoom: 14),
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
  AllTreesController(this._allTreesProvider, SessionStorage sessionStorage,
      PhotosService photosService)
      : super(sessionStorage, photosService);
  final AllTreesProvider _allTreesProvider;

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
      myTrees = await _allTreesProvider.getTrees();
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
    Navigator.of(Get.context!).pop();
    Analytics.buttonPressed('Tree details');
    Get.toNamed(TreeDetailsPage.path, arguments: myTree);
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
                seeDetailsButton(tree, context),
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

  Widget seeDetailsButton(MyTree tree, BuildContext context) {
    return PrimaryButton(
        title: 'see_details'.tr,
        isEnabled: true,
        onTap: () => viewDetails(tree));
  }
}
