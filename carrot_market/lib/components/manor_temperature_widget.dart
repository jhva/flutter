import 'package:flutter/material.dart';

class MannorTemperature extends StatelessWidget {
  //위젯시작될때 온도를 받아야함

  double mannorTemp;
  late int level;

  final List<Color> tempPerColors = [
    Color(0xff072038),
    Color(0xff0d3a65),
    Color(0xff186ec0),
    Color(0xff37b24d),
    Color(0xffffad13),
    Color(0xfff76707),
  ];
  MannorTemperature({super.key, required this.mannorTemp}) {
    _calcTemp();
  }

  void _calcTemp() {
    // 맨처음 생성될때 caclTemp 시작
    if (mannorTemp <= 20) {
      level = 0;
    } else if (mannorTemp > 20 && mannorTemp <= 32) {
      level = 1;
    } else if (mannorTemp > 32 && mannorTemp <= 36.5) {
      level = 2;
    } else if (mannorTemp > 36.5 && mannorTemp <= 40) {
      level = 3;
    } else if (mannorTemp > 40 && mannorTemp <= 50) {
      level = 4;
    } else if (mannorTemp > 50) {
      level = 5;
    }
  }

  Widget _makeTempLabelAndBar() {
    return Container(
      width: 60,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${mannorTemp}'C",
            style: TextStyle(
                color: tempPerColors[level],
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          ClipRRect(
            // borderradius 사용할때
            borderRadius: BorderRadius.circular(10),
            child: Container(
              //progress bar
              height: 6,
              color: Colors.black.withOpacity(0.2),
              child: Row(
                children: [
                  Container(
                    height: 6,
                    width: 60 / 99 * mannorTemp,
                    color: tempPerColors[level],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _makeTempLabelAndBar(),
              Container(
                margin: const EdgeInsets.only(left: 7),
                width: 30,
                height: 30,
                child: Image.asset("assets/images/level-${level}.jpg"),
              )
            ],
          ),
          const Text(
            "매너온도",
            style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 12,
                color: Colors.grey),
          )
        ],
      ),
    );
  }
}
