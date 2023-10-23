import 'package:flutter/material.dart';

class NoWifiCommunication extends StatelessWidget {
  const NoWifiCommunication({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: const Center(child: Text("ラズパイのアクセスポイントに接続していません")),
    );
  }
}
