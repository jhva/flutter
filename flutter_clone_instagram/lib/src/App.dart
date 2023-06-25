import 'package:flutter/material.dart';
import 'package:flutter_clone_instagram/src/components/image_data.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    //뒤로가기눌렀을때 이벤트 onWillPop
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(),
          body: Container(),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: ImageData(icon: IconsPath.homeOff),
                activeIcon: ImageData(icon: IconsPath.homeOff),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: ImageData(icon: IconsPath.homeOff),
                activeIcon: ImageData(icon: IconsPath.homeOff),
                label: 'Home',
              ),
            ],
          ),
        ),
        onWillPop: () async {
          return false; //android 자체 뒤로가기버튼 실행 유무
        });
  }
}
