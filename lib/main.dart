import 'package:ar_flutter_plugin_sample/view/anchor_ar_drawing_button.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  runApp(const MyApp());
  await [Permission.location].request();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // var _currentPageIndex = 0;
  // final _pages = <Widget>[
  //   const AnchorArDrawingButton(),
  //   const PlaneArDrawingButton()
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("アプリ"),
        ),
        body: Center(child: AnchorArDrawingButton())
        // body: _pages[_currentPageIndex],
        // bottomNavigationBar: NavigationBar(
        //     onDestinationSelected: (int index) {
        //       setState(() {
        //         _currentPageIndex = index;
        //       });
        //     },
        //     selectedIndex: _currentPageIndex,
        //     destinations: const [
        //       NavigationDestination(icon: Icon(Icons.view_in_ar), label: 'Anchor'),
        //       NavigationDestination(icon: Icon(Icons.crop_square), label: 'Plane'),
        //     ]),
        );
  }
}
