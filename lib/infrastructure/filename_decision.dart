import 'package:flutter/cupertino.dart';
import 'package:network_info_plus/network_info_plus.dart';

class FilenameDecision {
  static final info = NetworkInfo();
  static Map<String, String> filename = {
    '192.168.249.50': '1.glb',
    '192.168.249.99': '2.glb',
  };
  static decisionFilename() async {
    final wifiIP = await info.getWifiIP();
    debugPrint(wifiIP);
    debugPrint(filename[wifiIP]);
    return filename[wifiIP];
  }
}
