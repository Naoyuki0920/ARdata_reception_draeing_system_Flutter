import 'package:ar_flutter_plugin_sample/localandwebobjectsexample.dart';
import 'package:flutter/material.dart';

class AnchorArDrawingButton extends StatelessWidget {
  const AnchorArDrawingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
      child: const Text("Anchor AR表示"),
      onPressed: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const LocalAndWebObjectsWidget()))
      },
    ));
  }
}
