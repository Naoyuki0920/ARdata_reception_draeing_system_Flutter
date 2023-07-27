import 'package:ar_flutter_plugin_sample/infrastructure/ar_object_download.dart';
import 'package:ar_flutter_plugin_sample/view/localandwebobjectsexample.dart';
import 'package:flutter/material.dart';

class AnchorArDrawingButton extends StatelessWidget {
  const AnchorArDrawingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
      child: const Text("Anchor AR表示"),
      onPressed: () {
        ArObjectDownload.downloadFile(
            "http://192.168.186.137:5000/get_glb", "Astronaut.glb");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const LocalAndWebObjectsWidget()));
      },
    ));
  }
}
