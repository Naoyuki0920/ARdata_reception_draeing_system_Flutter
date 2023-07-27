import 'package:ar_flutter_plugin_sample/objectsonplanesexample.dart';
import 'package:flutter/material.dart';

class PlaneArDrawingButton extends StatelessWidget {
  const PlaneArDrawingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
      child: const Text("Plane AR表示"),
      onPressed: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ObjectsOnPlanesWidget()))
      },
    ));
  }
}
