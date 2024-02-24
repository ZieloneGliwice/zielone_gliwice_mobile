import 'dart:async';
import 'dart:math';

import 'package:ar_flutter_plugin_flutterflow/datatypes/node_types.dart';
import 'package:ar_flutter_plugin_flutterflow/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin_flutterflow/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin_flutterflow/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin_flutterflow/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin_flutterflow/models/ar_node.dart';
import 'package:ar_flutter_plugin_flutterflow/widgets/ar_view.dart';
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
                      controller.birdFound();
                    },
                    child: Obx(() => Text(controller.test.value)),
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
  Random rng = Random();
  late Vector3 startPosition;
  late Vector3 currentPosition;
  RxString test = ''.obs;

  dynamic args = Get.arguments;
  bool hasEntry = false;

  //variables necessary for looking for the birds
  RxBool birdShown = false.obs;
  final double minimalDistance = 15.0; //in meters
  final int chanceToFind = 3; // 1/chanceToFind
  final int lookInterval = 3; //in seconds

  final int speciesAmount = 22;

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
    hasEntry = args['hasEntry'] as bool;

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
      contentPadding:
          const EdgeInsets.only(top: 6, bottom: 18, left: 6, right: 6),
      actions: <Widget>[
        cancelButton,
        continueButton,
      ],
      actionsAlignment: MainAxisAlignment.spaceAround,
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
    Get.toNamed(AddTreePage.path,
            arguments: <String, dynamic>{'points': 3, 'hasEntry': hasEntry})!
        .then((_) => Get.back());
  }

  Future<void> addNodeInFrontOfUser(String name) async {
    // Get current camera pose
    final Matrix4? cameraPose = await arSessionManager.getCameraPose();

    if (cameraPose != null) {
      //Create unit vector
      final Vector3 forwardVector = Vector3(0.0, 0.0, -1.0);

      //Rotate the unit vector to point perpendicular to the camera
      forwardVector.applyMatrix3(cameraPose.getRotation());

      //Distance from camera
      const double distance = 10;

      //Target position
      final Vector3 cameraPosition = cameraPose.getTranslation();
      final Vector3 newPosition = cameraPosition + forwardVector * distance;

      //Rotate target
      final Vector3 newRotation = cameraPose.matrixEulerAngles;

      //Target looks to user
      newRotation.add(Vector3(0 * pi / 180, 0, -10 * pi / 180));

      //Randomize rotation
      newRotation.add(Vector3(randomDoubleBetween(-80, 80) * pi / 180, 0,
          randomDoubleBetween(-3, 3) * pi / 180));

      //Remove rotational deviation
      newRotation[1] = 0;

      //Raise target
      newPosition.add(Vector3(0, 3, 0));

      //Randomly move target horizontally and vertically
      newPosition.add(
          Vector3(randomDoubleBetween(-5, 5), randomDoubleBetween(-1, 3), 0));

      //Randomize target size
      final double size = randomDoubleBetween(2.0, 3.0);

      final ARNode myNode = ARNode(
          type: NodeType.localGLTF2,
          uri: 'assets/ar/birds/$name.gltf',
          scale: Vector3(size, size, size),
          position: newPosition,
          // rotation: newRotation,
          eulerAngles: newRotation, //,
          name: 'bird${nodes.length}');

      arObjectManager.addNode(myNode);
      nodes.add(myNode);
      birdShown.value = true;
    }
  }

  Future<void> startLookingForBird() async {
    final Matrix4? cameraPose = await arSessionManager.getCameraPose();
    startPosition = cameraPose!.getTranslation();

    //Look for the bird every lookInterval seconds
    timer = Timer.periodic(
      Duration(seconds: lookInterval),
      (Timer t) => lookForBird(),
    );
  }

  Future<void> lookForBird() async {
    //Check if bird is already found

    // if (birdShown.value) {
    //   return;
    // }

    //Check if user is moving (at least minimalDistance meters from his starting position)

    final Matrix4? cameraPose = await arSessionManager.getCameraPose();
    currentPosition = cameraPose!.getTranslation();
    final double distanceWalked =
        calculateDistance(startPosition, currentPosition);
    test.value = distanceWalked.toString();
    if (distanceWalked < minimalDistance) {
      return;
    }
    startPosition = currentPosition;

    //Random chance to find bird (1 in chanceToFind)

    if (rng.nextInt(chanceToFind) == 1) {
      birdFound();
    }
  }

  double calculateDistance(Vector3 start, Vector3 now) {
    double distance = 0;
    distance = sqrt(pow(now[0] - start[0], 2) +
        pow(now[1] - start[1], 2) +
        pow(now[2] - start[2], 2));

    return distance;
  }

  void birdFound() {
    final int rndBirdId = rng.nextInt(speciesAmount) + 1;
    addNodeInFrontOfUser('bird$rndBirdId');
  }

  double randomDoubleBetween(double min, double max) {
    return min + rng.nextDouble() * (max - min);
  }
}
