import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../analytics/analytics.dart';
import '../model/errors.dart';
import '../model/my_tree.dart';
import '../model/tree_details.dart';
import '../network/api_dio.dart';
import '../network/tree_details_provider.dart';
import '../services/photos_service.dart';
import '../ui/activity_indicator.dart';
import '../ui/date.dart';
import '../ui/dimen.dart';
import '../ui/error_view.dart';
import '../ui/gray_app_bar.dart';
import '../ui/styles.dart';
import '../utils/session_controller.dart';
import '../utils/session_storage.dart';

class TreeDetailsPage extends GetView<TreeDetailsController> {
  const TreeDetailsPage({super.key});

  static const String path = '/tree_details_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GrayAppBar(
          title: Text('tree_title'.tr),
        ),
        backgroundColor: ApplicationColors.background,
        body: controller.obx(
          (TreeDetails? details) {
            if (details != null && controller.tree != null) {
              return _detailsContent(controller.tree!, details);
            } else {
              return _errorView(CommonError().identifier);
            }
          },
          onLoading: const ActivityIndicator(),
          onError: (String? error) => _errorView(error),
        ));
  }

  Widget _errorView(String? error) {
    Analytics.visitedErrorScreen(TreeDetailsPage.path);
    final ZGError zgError = ZGError.from(error);

    return ErrorView.from(zgError, controller.getDetails);
  }

  Widget _detailsContent(MyTree myTree, TreeDetails details) {
    Analytics.visitedScreen(TreeDetailsPage.path);
    return CustomScrollView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        slivers: <SliverToBoxAdapter>[
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(Dimen.marginNormal),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        myTree.species?.capitalize ?? '',
                        style: ApplicationTextStyles.bodyTextStyle,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Date(dateString: myTree.formattedTimeStamp())
                    ],
                  ),
                ),
                _imagesCarousel(details),
                Padding(
                  padding: const EdgeInsets.all(Dimen.marginNormal),
                  child: Row(
                    children: <Widget>[
                      const SizedBox(
                        width: 22,
                        child: Icon(
                          Icons.pin_drop_outlined,
                          color: ApplicationColors.black,
                        ),
                      ),
                      const SizedBox(
                        width: Dimen.marginNormal,
                      ),
                      Expanded(
                        child: Text(
                          details.address ?? '-',
                          style: ApplicationTextStyles.bodyTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                if (details.location != null) ...<Widget>{
                  AspectRatio(
                    aspectRatio: 1.85,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimen.marginNormal,
                          vertical: Dimen.marginTiny),
                      child: ClipRRect(
                        clipBehavior: Clip.hardEdge,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        child: SizedBox(
                          height: 500,
                          child: GoogleMap(
                            zoomGesturesEnabled: false,
                            scrollGesturesEnabled: false,
                            tiltGesturesEnabled: false,
                            rotateGesturesEnabled: false,
                            zoomControlsEnabled: false,
                            myLocationButtonEnabled: false,
                            mapToolbarEnabled: false,
                            initialCameraPosition: CameraPosition(
                                target: details.location!, zoom: 15),
                            markers: controller.markers,
                          ),
                        ),
                      ),
                    ),
                  ),
                },
                Container(
                  decoration:
                      const BoxDecoration(color: ApplicationColors.white),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      _treeDetail(
                        leftText: 'age'.tr,
                        rightText:
                            '${controller.age} ${"years".tr}' ?? 'no_data'.tr,
                      ),
                      const Divider(height: 2),
                      _treeDetail(
                        leftText: 'tree_circumference'.tr,
                        rightText: '${controller.details!.perimeter} cm' ??
                            'no_data'.tr,
                      ),
                      const Divider(height: 2),
                      _treeDetail(
                        leftText:
                            '${"tree".tr} ${details.state?.capitalize}' ?? '',
                      ),
                      if (details.stateDescription == null ||
                          details.stateDescription!.isEmpty ||
                          details.stateDescription == '' ||
                          details.stateDescription == ' ')
                        const SizedBox.shrink()
                      else
                        _treeDetail(
                          leftText: details.stateDescription ?? '',
                        ),
                      const Divider(height: 2),
                      _treeDetail(
                          leftText:
                              '${"consumed_km_1".tr} ${controller.kmConsumed} ${"consumed_km_2".tr}',
                          rightText: '${controller.fumesConsumed}kg CO2' ??
                              'no_data'.tr,
                          rightComment:
                              '${controller.fumesIncome}zł/${"year".tr}'),
                      const Divider(height: 2),
                      _treeDetail(
                          leftText: 'amount_dirt_cleared'.tr,
                          rightText:
                              '${controller.dirtRemoved}kg' ?? 'no_data'.tr,
                          rightComment:
                              '${controller.dirtIncome}zł/${"year".tr}'),
                      const Divider(height: 2),
                      _treeDetail(
                          leftText: 'amount_water_stored'.tr,
                          rightText:
                              '${controller.waterStored}l' ?? 'no_data'.tr,
                          rightComment:
                              '${controller.waterIncome}zł/${"year".tr}'),
                      const Divider(height: 2),
                      _treeDetail(
                        leftText: 'yearly_income'.tr,
                        rightText:
                            '${controller.yearlyIncome} zł' ?? 'no_data'.tr,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                )
              ],
            ),
          )
        ]);
  }

  Widget _imagesCarousel(TreeDetails details) {
    return CarouselSlider(
      options: CarouselOptions(
          aspectRatio: 1.85,
          enableInfiniteScroll: false,
          enlargeCenterPage: true),
      items: details.photos.map((String photo) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              clipBehavior: Clip.hardEdge,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: ApplicationColors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Image.network(
                photo,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return const ActivityIndicator();
                },
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _treeDetail(
      {String? leftText, String? rightText, String? rightComment}) {
    return Padding(
      padding: const EdgeInsets.all(Dimen.marginNormal),
      child: Row(
        children: [
          Expanded(
            flex: 10,
            child: Text(
              leftText ?? '',
              style: ApplicationTextStyles.bodyTextStyle,
            ),
          ),
          const Expanded(flex: 2, child: SizedBox()),
          Expanded(
            flex: 4,
            child: rightComment == null
                ? Text(
                    rightText ?? '',
                    style: ApplicationTextStyles.bodyBoldTextStyle,
                  )
                : Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          rightText ?? '',
                          style: ApplicationTextStyles.bodyBoldTextStyle,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          rightComment,
                          style:
                              ApplicationTextStyles.placeholderHeaderTextStyle,
                        ),
                      )
                    ],
                  ),
          )
        ],
      ),
    );
  }
}

class TreeDetailsController extends SessionController
    with StateMixin<TreeDetails> {
  TreeDetailsController(this._treeDetailsProvider,
      SessionStorage sessionStorage, PhotosService photosService)
      : super(sessionStorage, photosService);
  final TreeDetailsProvider _treeDetailsProvider;

  MyTree? tree;
  TreeDetails? details;
  Set<Marker> markers = <Marker>{};

  int? age;
  int? kmConsumed;
  double? fumesConsumed;
  double? dirtRemoved;
  int? waterStored;
  int? yearlyIncome;
  int? fumesIncome;
  int? dirtIncome;
  int? waterIncome;

  @override
  void onInit() {
    super.onInit();

    tree = Get.arguments as MyTree?;

    getDetails();
  }

  Future<void> getDetails() async {
    change(null, status: RxStatus.loading());

    try {
      details = await _treeDetailsProvider.getTreeDetails(tree!.id!);

      if (details != null) {
        await updateLocationMarker();
        calculateAttributes(details!);
        change(details, status: RxStatus.success());
      } else {
        handleError(CommonError());
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

  Future<void> updateLocationMarker() async {
    final LatLng? location = details?.location;
    if (location != null) {
      final Marker marker = Marker(
          markerId: const MarkerId('1'),
          position: location,
          icon: await BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(size: Size(15, 15)),
              'assets/images/map_marker.png'));
      markers = <Marker>{marker};
    } else {
      markers = <Marker>{};
    }
  }

  void calculateAttributes(TreeDetails details) {
    //Ze wzorów
    age = 15;
    kmConsumed = 30;
    fumesConsumed = 3;
    fumesIncome = 400;
    dirtRemoved = 4.45;
    dirtIncome = 300;
    waterStored = 43;
    waterIncome = 230;
    yearlyIncome = 1200;
  }
}
