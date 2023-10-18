import 'package:network_info_plus/network_info_plus.dart';

class ApiUrlDecision {
  static final info = NetworkInfo();
  static Map<String, String> apiURL = {
    'RaspberryPi_1': 'http://192.168.75.11:5000/get_glb',
    'RaspberryPi_2': 'http://192.168.75.12:5000/get_glb',
  };
  static decisionAPI() async {
    final wifiName = await info.getWifiName();
    return apiURL[wifiName];
  }
}
