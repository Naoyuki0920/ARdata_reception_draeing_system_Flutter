import 'package:flutter/cupertino.dart';
import 'package:network_info_plus/network_info_plus.dart';

class ApiUrlDecision {
  static final info = NetworkInfo();
  static Map<String, String> apiURL = {
    // Xperia5 テザリング
    '192.168.249.50': 'http://192.168.75.11:5000/get_glb',  //子機1
    '192.168.249.99': 'http://192.168.186.137:5000/get_glb',
  };
  static decisionAPI() async {
    final wifiIP = await info.getWifiIP();
    debugPrint(wifiIP);
    debugPrint(apiURL[wifiIP]);
    return apiURL[wifiIP];
  }
}
