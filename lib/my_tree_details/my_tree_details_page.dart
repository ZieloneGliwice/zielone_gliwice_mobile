import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../model/errors.dart';
import '../model/my_tree.dart';
import '../model/tree_details.dart';
import '../network/api_dio.dart';
import '../network/my_tree_details_provider.dart';
import '../ui/activity_indicator.dart';
import '../ui/date.dart';
import '../ui/dimen.dart';
import '../ui/error_view.dart';
import '../ui/gray_app_bar.dart';
import '../ui/styles.dart';
import '../utils/session_controller.dart';
import '../utils/session_storage.dart';

class MyTreeDetailsPage extends GetView<MyTreeDetailsController> {
  const MyTreeDetailsPage({super.key});

  static const String path = '/my_tree_details_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GrayAppBar(
        title: Text('my_tree_title'.tr),
      ),
      backgroundColor: ApplicationColors.background,
      body: controller.obx((TreeDetails? details) {
        if (details != null && controller.myTree != null) {
          return _detailsContent(controller.myTree!, details);
        } else {
          return _errorView(CommonError().identifier);
        }
      },
          onLoading: const ActivityIndicator(),
          onError: (String? error) => _errorView(error),
    ));
  }

  Widget _errorView(String? error) {
    final ZGError zgError = ZGError.from(error);

    return ErrorView.from(zgError, controller.getDetails);
  }

  Widget _detailsContent(MyTree myTree, TreeDetails details) {
    return Padding(
      padding: const EdgeInsets.all(Dimen.marginNormal),
      child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <SliverFillRemaining>[
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                  const SizedBox(height: Dimen.marginNormal,),
                  AspectRatio(
                    aspectRatio: 1.85,
                    child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(
                          color: ApplicationColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Image.network(
                          details.treeImageUrl() ?? '',
                          fit: BoxFit.cover,
                        )
                    ),
                  ),
                  const SizedBox(height: Dimen.marginNormal,),
                  Row(
                    children: [
                      const SizedBox(
                        width: 22,
                        child: Icon(Icons.pin_drop_outlined, color: ApplicationColors.black,),
                      ),
                      const SizedBox(width: Dimen.marginNormal,),
                      Expanded(
                        child: Text(
                          details.address ?? '-',
                          style: ApplicationTextStyles.bodyTextStyle,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Dimen.marginNormal,),
                  if (details.latLong != null) ... <Widget>{
                    AspectRatio(
                      aspectRatio: 1.85,
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(
                          color: ApplicationColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child:  GoogleMap(
                          myLocationEnabled: false,
                          myLocationButtonEnabled: false,
                          initialCameraPosition: CameraPosition(target: details.latLong!, zoom: 15),
                          markers: controller.markers,
                        ),
                      ),
                    ),
                    const SizedBox(height: Dimen.marginNormal,),
                  },
                  Text(
                    details.state?.capitalize ?? '',
                    style: ApplicationTextStyles.bodyTextStyle,
                  ),
                  const SizedBox(height: Dimen.marginNormal,),
                  Text(
                    details.stateDescription ?? '',
                    style: ApplicationTextStyles.bodyTextStyle,
                  ),
                ],
              ),
            )
          ]
      ),
    );
  }
}

class MyTreeDetailsController extends SessionController with StateMixin<TreeDetails> {
  MyTreeDetailsController(this._myTreeDetailsProvider, SessionStorage sessionStorage) : super(sessionStorage);
  final MyTreeDetailsProvider _myTreeDetailsProvider;

  MyTree? myTree;
  TreeDetails? details;
  Set<Marker> markers = <Marker>{};

  @override
  void onInit() {
    super.onInit();

    myTree = Get.arguments as MyTree?;
    getDetails();
  }

  Future<void> getDetails() async {
    change(null, status: RxStatus.loading());

    try {
      details = await _myTreeDetailsProvider.getTreeDetails(myTree!.id!);

      if (details != null) {
        await updateLocationMarker();
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
    if (details?.latLong != null) {
      final Marker marker = Marker(markerId: const MarkerId('1'), position: details!.latLong!, icon: await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(size: Size(15, 15)), 'assets/images/map_marker.png'));
      markers = <Marker>{ marker };
    } else {
      markers = <Marker>{};
    }
  }
}
