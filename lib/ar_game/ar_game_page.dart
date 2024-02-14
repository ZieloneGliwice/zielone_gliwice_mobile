import 'dart:async';
import 'dart:math';

import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:ar_flutter_plugin/widgets/ar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vector_math/vector_math_64.dart';

import '../add_tree/add_tree_page.dart';
import '../analytics/analytics.dart';
import '../model/my_trees.dart';
import '../ui/gray_app_bar.dart';
import '../ui/styles.dart';
import '../utils/session_controller.dart';

class ArGamePage extends GetView<ArGameController> {
  const ArGamePage({super.key});

  static const String path = '/ar_game_page';

  @override
  Widget build(BuildContext context) {
    Analytics.visitedScreen(ArGamePage.path);
    return Scaffold(
      appBar: GrayAppBar(
        title: Text('ar_game_title'.tr),
      ),
      backgroundColor: ApplicationColors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Stack(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * .8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: ARView(onARViewCreated: controller.onARViewCreated),
                  ),
                ),
                Positioned.fill(
                    bottom: 20,
                    child: Obx(
                      () => Align(
                        alignment: Alignment.bottomCenter,
                        child: controller.birdShown.value
                            ? addBirdButton()
                            : const SizedBox.shrink(),
                      ),
                    )),
              ],
            ),
            Row(
              children: <Widget>[
                const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      controller.addNodeInFrontOfUser();
                    },
                    child: const Text('Pokaż ptaka (tymczasowe)'),
                  ),
                ),
                const SizedBox(width: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget addBirdButton() {
    return ElevatedButton(
      onPressed: () {
        controller.showAddTreeDialog();
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: ApplicationColors.orange,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(18)))),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text('add_bird'.tr,
            style: ApplicationTextStyles.arGameButtonTextStyle),
      ),
    );
  }
}

class ArGameController extends SessionController with StateMixin<MyTrees> {
  ArGameController(super.sessionStorage, super.photosService);

  late ARSessionManager arSessionManager;
  late ARObjectManager arObjectManager;
  late ARAnchorManager arAnchorManager;
  ARNode? localObjectNode;
  ARNode? webObjectNode;
  List<ARNode> nodes = <ARNode>[];
  Timer? timer;

  RxBool birdShown = false.obs;

  Future<void> onARViewCreated(
      ARSessionManager arSessionManager,
      ARObjectManager arObjectManager,
      ARAnchorManager arAnchorManager,
      ARLocationManager arLocationManager) async {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;
    this.arAnchorManager = arAnchorManager;

    await this.arSessionManager.onInitialize(
          showFeaturePoints: false,
          showPlanes: true,
          customPlaneTexturePath: 'triangle.png',
          showWorldOrigin: false,
          handleTaps: true,
          showAnimatedGuide: false,
        );

    this.arObjectManager.onInitialize();
    this.arObjectManager.onNodeTap = handleTap;

    startLookingForBird();
  }

  void handleTap(List<String> nodeNames) {
    showAddTreeDialog();
  }

  void showAddTreeDialog() {
    final BuildContext context = Get.context!;
    final Widget cancelButton = TextButton(
      child: Text(
        'cancel'.tr,
        style: ApplicationTextStyles.arGameAlertCancelTextStyle,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    final Widget continueButton = TextButton(
      child: Text(
        'next'.tr,
        style: ApplicationTextStyles.arGameAlertNextTextStyle,
      ),
      onPressed: () {
        Navigator.of(context).pop();
        alertContinue();
      },
    );

    final AlertDialog alert = AlertDialog(
      title: Text(
        'add_bird_dialog_title'.tr,
        textAlign: TextAlign.center,
        style: ApplicationTextStyles.arGameAlertTitleTextStyle,
      ),
      titlePadding: const EdgeInsets.only(top: 18),
      content: Text(
        'add_bird_dialog_content'.tr,
        textAlign: TextAlign.center,
        style: ApplicationTextStyles.arGameAlertContentTextStyle,
      ),
      contentPadding: const EdgeInsets.only(top: 6, bottom: 18),
      actions: <Widget>[
        cancelButton,
        continueButton,
      ],
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(18))),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void alertContinue() {
    nodes.forEach((ARNode node) {
      arObjectManager.removeNode(node);
    });
    nodes = <ARNode>[];
    birdShown.value = false;
    addNewTree();
  }

  Future<void> addNewTree() async {
    Analytics.buttonPressed('Add tree');
    await photosService.clearCachedPhotos();
    arSessionManager.dispose();
    Get.toNamed(AddTreePage.path, arguments: <String, int>{'points': 3})!
        .then((_) => Get.back());
  }

  Future<void> addNodeInFrontOfUser() async {
    // Pobieranie pozy kamery
    final Matrix4? cameraPose = await arSessionManager.getCameraPose();

    if (cameraPose != null) {
      //Wektor jednostkowy do odległości
      final Vector3 forwardVector = Vector3(0.0, 0.0, -1.0);

      //Rotacja jednostkowego wektoru, aby był skierowany prostopadle do kamery
      forwardVector.applyMatrix3(cameraPose.getRotation());
      cameraPose.getTranslation();

      //Odległość od aparatu
      const double distance = 10;

      //Pozycja celu
      final Vector3 cameraPosition = cameraPose.getTranslation();
      final Vector3 newPosition = cameraPosition + forwardVector * distance;

      //Obrót celu
      final Vector3 newRotation = cameraPose.matrixEulerAngles;

      //wartości domyślne by ptak patrzył na kamerę
      newRotation.add(Vector3(110 * pi / 180, 0, -10 * pi / 180));

      //Usunięcie odchylenia obrotowego
      newRotation[1] = 0;

      //Podnieś cel
      newPosition.add(Vector3(0, 3, 0));

      final ARNode myNode = ARNode(
          type: NodeType.localGLTF2,
          uri: 'assets/ar/Chicken_01/Chicken_01.gltf',
          scale: Vector3(0.6, 0.6, 0.6),
          position: newPosition,
          // rotation: newRotation,
          eulerAngles: newRotation, //,
          name: 'Kura${nodes.length}');

      arObjectManager.addNode(myNode);
      nodes.add(myNode);
      birdShown.value = true;
    }
  }

  void startLookingForBird() {
    timer =
        Timer.periodic(const Duration(seconds: 15), (Timer t) => birdFound());
  }

  void birdFound() {
    addNodeInFrontOfUser();
  }
}
