// ignore_for_file: use_build_context_synchronously, must_be_immutable
import 'package:ar_flutter_plugin_sample/infrastructure/ar_object_download.dart';
import 'package:ar_flutter_plugin_sample/view/localandwebobjectsexample.dart';
import 'package:ar_flutter_plugin_sample/view/no_wifi_communication.dart';
import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';

class AnchorArDrawingButton extends StatelessWidget {
  AnchorArDrawingButton({super.key});

  Map<String, String> apiURLList = {
    'RaspberryPi_1': 'http://192.168.75.11:5000/get_glb',
    'RaspberryPi_2': 'http://192.168.75.12:5000/get_glb',
  };

  Map<String, String> filenameList = {
    'RaspberryPi_1': '1.glb',
    'RaspberryPi_2': '2.glb',
  };

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
      child: const Text("AR表示"),
      onPressed: () async {
        final info = NetworkInfo();
        final wifiName = await info.getWifiName();
        if (wifiName == null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const NoWifiCommunication()));
        } else if (wifiName == '"RaspberryPi_1"') {
          await ArObjectDownload.downloadFile(
              'http://192.168.75.11:5000/get_glb', "1.glb");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const LocalAndWebObjectsWidget(
                        fileName: "1.glb",
                      )));
        } else if (wifiName == '"RaspberryPi_2"') {
          await ArObjectDownload.downloadFile(
              'http://192.168.75.12:5000/get_glb', "2.glb");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const LocalAndWebObjectsWidget(
                        fileName: "2.glb",
                      )));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const NoWifiCommunication()));
        }
      },
    ));
  }
}
