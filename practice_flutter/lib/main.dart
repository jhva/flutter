import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_flutter/src/ScaffoldSample.dart';
import 'package:practice_flutter/src/model/rabbit.dart';
import 'package:practice_flutter/src/stateful_sample_widget.dart';
import 'package:practice_flutter/src/stateless_sample_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "flutter demo",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ScaffoldSample(),
    );
  }
}

//   @override
//   State<MyApp> createState() => _MyAppState();
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }
//
// class _MyAppState extends State<MyApp> {
//   int value = 0;
//
//   @override
//   void initState() {
//     value = 0;
//     super.initState();
//     Timer.periodic(const Duration(seconds: 1), (timer) {
//       setState(() {
//         value++;
//       });
//     });
//   }
//
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Flutterd Demo',
//       // home: StatelessSample(
//       //     title: "된다잘되네",
//       //     rabbit: Rabbit(name: "1", state: RabbitState.SLEEP)));
//       // home: value > 10
//       //     ? Container()
//       //     : StatefulSampleWidget(
//       //         title: "구멍df이있는",
//       //         rabbit: Rabbit(name: "1", state: RabbitState.SLEEP)));
//       home: ScaffoldSample(),
//     );
//   }
// }
//
