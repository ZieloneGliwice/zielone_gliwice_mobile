import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../analytics/analytics.dart';
import '../ui/activity_indicator.dart';
import '../ui/dimen.dart';
import '../ui/gray_app_bar.dart';
import '../ui/primary_button.dart';
import '../ui/styles.dart';

class MapPage extends GetView<MapPageController> {
  const MapPage({super.key});

  static const String path = '/map_page';

  @override
  Widget build(BuildContext context) {
    Analytics.visitedScreen(MapPage.path);
    return Scaffold(
      appBar: GrayAppBar(
        title: Text('tree_location'.tr),
      ),
      backgroundColor: ApplicationColors.white,
      body:
          controller.obx((_) => _body(), onLoading: const ActivityIndicator()),
    );
  }

  Widget _body() {
    return Stack(children: [
      GoogleMap(
        padding: const EdgeInsets.all(Dimen.marginSmall),
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        initialCameraPosition: controller.mainSquarePosition,
        onMapCreated: (GoogleMapController controller) {
          this.controller.mapController = controller;
          this.controller.goToTreeLocation();
        },
        onLongPress: controller.captureTreeLocation,
        markers: controller.markers.value,
      ),
      Positioned.fill(
        top: 30,
        child: Align(
          alignment: Alignment.topCenter,
          child: Card(
            elevation: 8,
            color: ApplicationColors.black,
            clipBehavior: Clip.hardEdge,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimen.marginSmall, vertical: Dimen.marginTiny),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.pin_drop,
                    color: ApplicationColors.white,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                      child: Text('add_tree_location'.tr,
                          style: ApplicationTextStyles.overlayTextStyle))
                ],
              ),
            ),
          ),
        ),
      ),
      Positioned.fill(
          child: Padding(
        padding: const EdgeInsets.only(bottom: Dimen.marginNormalPlus),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: PrimaryButton(
              title: 'save'.tr,
              isEnabled: controller.treeLocation.value != null,
              onTap: controller.save),
        ),
      ))
    ]);
  }
}

class MapPageController extends GetxController with StateMixin<bool> {
  MapPageController(this.location);

  GoogleMapController? mapController; // = Completer<GoogleMapController>();
  final Location location; // = Location();

  final LatLng defaultLocation =
      const LatLng(50.2938871, 18.6652026); // Main square

  Rxn<LatLng> treeLocation = Rxn<LatLng>();
  RxSet<Marker> markers = RxSet<Marker>();

  CameraPosition mainSquarePosition =
      const CameraPosition(target: LatLng(50.2938871, 18.6652026), zoom: 22);

  @override
  void onInit() {
    super.onInit();
    updateMarkers();
    treeLocation.value = Get.arguments as LatLng?;

    if (treeLocation.value == null) {
      getLocation();
    } else {
      goToTreeLocation();
    }
  }

  Future<void> getLocation() async {
    change(null, status: RxStatus.loading());
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      Analytics.logEvent('${MapPage.path}: Enable location service');
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        change(true, status: RxStatus.success());
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      Analytics.logEvent('${MapPage.path}: Location permission denied');
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        Analytics.logEvent('${MapPage.path}: Location permission granted');
        treeLocation.value = defaultLocation;
        change(true, status: RxStatus.success());
        return;
      }
    }

    locationData = await location.getLocation();

    final double? lat = locationData.latitude;
    final double? lon = locationData.longitude;

    if (lat != null && lon != null) {
      treeLocation.value = LatLng(lat, lon);
      goToTreeLocation();
    }

    change(true, status: RxStatus.success());
  }

  Future<void> goToTreeLocation() async {
    if (treeLocation.value != null) {
      final CameraPosition treePosition =
          CameraPosition(target: treeLocation.value!, zoom: 16);
      mapController
          ?.animateCamera(CameraUpdate.newCameraPosition(treePosition));
      change(true, status: RxStatus.success());
    } else {
      change(true, status: RxStatus.success());
    }
  }

  void captureTreeLocation(LatLng? location) {
    Analytics.logEvent('${MapPage.path}: Capture location');
    treeLocation.value = location;
  }

  void updateMarkers() {
    treeLocation.listen((LatLng? position) async {
      if (position != null) {
        final Marker marker = Marker(
            markerId: const MarkerId('1'),
            position: position,
            icon: await BitmapDescriptor.fromAssetImage(
                const ImageConfiguration(size: Size(15, 15)),
                'assets/images/map_marker.png'));
        markers.value = {marker};
      } else {
        markers.value = {};
      }
      update();
    });
  }

  void save() {
    Analytics.buttonPressed('Save');
    Analytics.logEvent('${MapPage.path}: Save location');
    return Get.back(result: treeLocation.value);
  }
}
