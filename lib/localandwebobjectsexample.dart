import 'dart:io';

import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
// ignore: depend_on_referenced_packages
import 'package:vector_math/vector_math_64.dart';
import 'package:path_provider/path_provider.dart';

class LocalAndWebObjectsWidget extends StatefulWidget {
  const LocalAndWebObjectsWidget({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _LocalAndWebObjectsWidgetState createState() =>
      _LocalAndWebObjectsWidgetState();
}

class _LocalAndWebObjectsWidgetState extends State<LocalAndWebObjectsWidget> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  //String localObjectReference;
  ARNode? localObjectNode;
  //String webObjectReference;
  ARNode? webObjectNode;
  ARNode? fileSystemNode;
  HttpClient? httpClient;

  @override
  void dispose() {
    super.dispose();
    arSessionManager!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Local & Web Objects'),
        ),
        body: Stack(children: [
          ARView(
            onARViewCreated: onARViewCreated,
            planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
          ),
          Align(
              alignment: FractionalOffset.bottomCenter,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: onFileSystemObjectAtOriginButtonPressed,
                        child: const Text(
                            "Add/Remove Filesystem\nObject at Origin")),
                    // ElevatedButton(
                    //     onPressed: onLocalObjectAtOriginButtonPressed,
                    //     child:
                    //         const Text("Add/Remove Local\nObject at Origin")),
                    ElevatedButton(
                        onPressed: onWebObjectAtOriginButtonPressed,
                        child: const Text("Add/Remove Web\nObject at Origin")),
                  ],
                ),
              ]))
        ]));
  }

  void onARViewCreated(
      ARSessionManager arSessionManager,
      ARObjectManager arObjectManager,
      ARAnchorManager arAnchorManager,
      ARLocationManager arLocationManager) {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;

    this.arSessionManager!.onInitialize(
          showFeaturePoints: false,
          showPlanes: true,
          customPlaneTexturePath: "Images/triangle.png",
          showWorldOrigin: true,
          handleTaps: false,
        );
    this.arObjectManager!.onInitialize();

    //Download model to file system
    httpClient = HttpClient();
    // _downloadFile(
    //     "https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Duck/glTF-Binary/Duck.glb",
    //     "LocalDuck.glb");

    _downloadFile(
        "http://192.168.186.79:5000/get_glb",
        "Astronaut.glb");

    // Alternative to use type fileSystemAppFolderGLTF2:
    // _downloadAndUnpack(
    //    "https://drive.google.com/uc?export=download&id=1fng7yiK0DIR0uem7XkV2nlPSGH9PysUs",
    //    "Chicken_01.zip");
  }

  Future<File> _downloadFile(String url, String filename) async {
    var request = await httpClient!.getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File('$dir/$filename');
    await file.writeAsBytes(bytes);
    debugPrint(
        "*******************************************************************************************************************");
    debugPrint("Downloading finished, path: " '$dir/$filename');
    return file;
  }

  Future<void> onLocalObjectAtOriginButtonPressed() async {
    if (localObjectNode != null) {
      arObjectManager!.removeNode(localObjectNode!);
      localObjectNode = null;
    } else {
      var newNode = ARNode(
          type: NodeType.localGLTF2,
          uri: "Models/Chicken_01/Chicken_01.gltf",
          scale: Vector3(0.2, 0.2, 0.2),
          position: Vector3(0.0, 0.0, 0.0),
          rotation: Vector4(1.0, 0.0, 0.0, 0.0));
      bool? didAddLocalNode = await arObjectManager!.addNode(newNode);
      localObjectNode = (didAddLocalNode!) ? newNode : null;
    }
  }

  Future<void> onWebObjectAtOriginButtonPressed() async {
    if (webObjectNode != null) {
      arObjectManager!.removeNode(webObjectNode!);
      webObjectNode = null;
      debugPrint(
          "=======================================================================================================================");
      debugPrint("delete");
    } else {
      var newNode = ARNode(
          type: NodeType.webGLB,
          uri:
              "http://192.168.186.79:5000/get_glb",
          scale: Vector3(0.2, 0.2, 0.2));
      bool? didAddWebNode = await arObjectManager!.addNode(newNode);
      webObjectNode = (didAddWebNode!) ? newNode : null;
      debugPrint(
          "-----------------------------------------------------------------------------------------------------------------------");
      debugPrint("ar add");
    }
  }

  Future<void> onFileSystemObjectAtOriginButtonPressed() async {
    if (fileSystemNode != null) {
      arObjectManager!.removeNode(fileSystemNode!);
      fileSystemNode = null;
    } else {
      var newNode = ARNode(
          type: NodeType.fileSystemAppFolderGLB,
          uri: "Astronaut.glb",
          scale: Vector3(0.2, 0.2, 0.2));
      //Alternative to use type fileSystemAppFolderGLTF2:
      //var newNode = ARNode(
      //    type: NodeType.fileSystemAppFolderGLTF2,
      //    uri: "Chicken_01.gltf",
      //    scale: Vector3(0.2, 0.2, 0.2));
      bool? didAddFileSystemNode = await arObjectManager!.addNode(newNode);
      fileSystemNode = (didAddFileSystemNode!) ? newNode : null;
    }
  }
}
