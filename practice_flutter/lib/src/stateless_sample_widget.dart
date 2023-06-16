import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/rabbit.dart';

class StatelessSample extends StatelessWidget {
  final String title;
  final Rabbit rabbit;

  StatelessSample({super.key, required this.title, required this.rabbit}) {
    Timer.periodic(Duration(seconds: 1), (timer) {
      print(timer.tick);
      int idx = timer.tick % 4;
      switch (idx) {
        case 0:
          rabbit.updateState(RabbitState.RUN);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Container(
            child: Center(
                child: Text(rabbit.state.toString(),
                    style: TextStyle(fontSize: 20)))));
  }
}
