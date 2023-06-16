import 'dart:async';

import 'package:flutter/material.dart';

import 'model/rabbit.dart';

class StatefulSampleWidget extends StatefulWidget {
  String title;
  Rabbit rabbit;
  StatefulSampleWidget({required this.title, required this.rabbit});

  @override
  State<StatefulSampleWidget> createState() => _StatefulSampleWidgetState();
}

class _StatefulSampleWidgetState extends State<StatefulSampleWidget> {
  bool stateBool = false;

  @override
  void dispose() {
    // TODO: implement dispose
    print("dispse");
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    print("init State!!");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    print("didChangeDependencies !! ");
  }

  @override
  void didUpdateWidget(StatefulSampleWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print(
        "oldWidget :${oldWidget.hashCode} <> this widget :${widget.hashCode}");
    if (oldWidget.hashCode != widget.hashCode) {
      print("didUpdateWidget");
    }
  }

  @override
  Widget build(BuildContext context) {
    print("build !! ");

    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Container(
            child: Center(
                child: Text(widget.rabbit.state.toString(),
                    style: TextStyle(fontSize: 20)))),
        floatingActionButton: FloatingActionButton(
          //버튼
          onPressed: () {
            print("press button");
            setState(() {
              stateBool = !stateBool;
            });
          },
          child: Text("버튼"),
        ));
  }
}
