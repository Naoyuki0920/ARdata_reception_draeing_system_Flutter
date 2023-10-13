import 'package:ar_flutter_plugin_sample/infrastructure/api_url_decision.dart';
import 'package:ar_flutter_plugin_sample/infrastructure/ar_object_download.dart';
import 'package:ar_flutter_plugin_sample/view/objectsonplanesexample.dart';
import 'package:flutter/material.dart';

class PlaneArDrawingButton extends StatelessWidget {
  const PlaneArDrawingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
      child: const Text("Plane AR表示"),
      onPressed: () async {
        String url = await ApiUrlDecision.decisionAPI();
        ArObjectDownload.downloadFile(url, "Astronaut.glb");
        // ignore: use_build_context_synchronously
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ObjectsOnPlanesWidget()));
      },
    ));
  }
}
