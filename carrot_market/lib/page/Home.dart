import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PreferredSizeWidget appBarWidget() {
    return AppBar(
      title: GestureDetector(
        onTap: () {
          print('클릭');
        },
        child: const Row(
          children: [
            Text(
              "아라동",
              style: TextStyle(color: Colors.black),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.black,
            ),
          ],
        ),
      ),
      // 페이지이름
      elevation: 1, // 라인없애기
      actions: [
        IconButton(
            onPressed: () {}, icon: Icon(Icons.search, color: Colors.black)),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.tune,
              color: Colors.black,
            )),
        IconButton(
            onPressed: () {},
            icon: SvgPicture.asset("assets/svg/bell.svg", width: 22)),
      ], // 가장 끝 우측끝에 배치되는

      backgroundColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(),
      body: Container(),
      bottomNavigationBar: Container(),
    );
  }
}
