import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'home.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late int _currentPageIdx;
  @override
  void initState() {
    super.initState();
    _currentPageIdx = 0;
  }

  BottomNavigationBarItem _bottomNavigationBarItem(
      String iconName, String label) {
    return BottomNavigationBarItem(
        activeIcon: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: SvgPicture.asset(
            "assets/svg/${iconName}_on.svg",
            width: 22,
          ),
        ),
        icon: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: SvgPicture.asset(
            "assets/svg/${iconName}_off.svg",
            width: 22,
          ),
        ),
        label: label);
  }

  Widget bottomNavigationBarWidget() {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed, //애니메이션 타입 설정
        onTap: (int index) {
          print(index);
          setState(() {
            _currentPageIdx = index; //애니메이션호과가 발동됨
          });
        },
        currentIndex: _currentPageIdx,
        selectedItemColor: Colors.black,
        selectedFontSize: 12,
        selectedLabelStyle: const TextStyle(color: Colors.black),
        items: [
          _bottomNavigationBarItem(
            "home",
            "홈",
          ),
          _bottomNavigationBarItem(
            "notes",
            "동네생활",
          ),
          _bottomNavigationBarItem(
            "location",
            "내 근처",
          ),
          _bottomNavigationBarItem(
            "chat",
            "채팅",
          ),
          _bottomNavigationBarItem(
            "user",
            "나의 당근",
          ),
        ]);
  }

  Widget bodyWidget() {
    switch (_currentPageIdx) {
      case 0:
        return const Home();
        break;
      case 1:
        return Container();
        break;
      case 2:
        return Container();
        break;
      case 3:
        return Container();
        break;
      case 4:
        return Container();
        break;
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyWidget /**/ (),
      bottomNavigationBar: bottomNavigationBarWidget(),
    );
  }
}
