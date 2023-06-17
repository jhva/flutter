import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, String>> datas = [];

  late int _currentPageIdx;
  @override
  void initState() {
    super.initState();
    _currentPageIdx = 0;
    datas = [
      {
        "cid": "1",
        "image": "assets/images/ara-1.jpg",
        "title": "네메시스 축구화275",
        "location": "제주 제주시 아라동",
        "price": "30000",
        "likes": "2"
      },
      {
        "cid": "2",
        "image": "assets/images/ara-2.jpg",
        "title": "LA갈비 5kg팔아요~",
        "location": "제주 제주시 아라동",
        "price": "100000",
        "likes": "5"
      },
      {
        "cid": "3",
        "image": "assets/images/ara-3.jpg",
        "title": "치약팝니다",
        "location": "제주 제주시 아라동",
        "price": "5000",
        "likes": "0"
      },
      {
        "cid": "4",
        "image": "assets/images/ara-4.jpg",
        "title": "[풀박스]맥북프로16인치 터치바 스페이스그레이",
        "location": "제주 제주시 아라동",
        "price": "2500000",
        "likes": "6"
      },
      {
        "cid": "5",
        "image": "assets/images/ara-5.jpg",
        "title": "디월트존기임팩",
        "location": "제주 제주시 아라동",
        "price": "150000",
        "likes": "2"
      },
      {
        "cid": "6",
        "image": "assets/images/ara-6.jpg",
        "title": "갤럭시s10",
        "location": "제주 제주시 아라동",
        "price": "180000",
        "likes": "2"
      },
      {
        "cid": "7",
        "image": "assets/images/ara-7.jpg",
        "title": "선반",
        "location": "제주 제주시 아라동",
        "price": "15000",
        "likes": "2"
      },
      {
        "cid": "8",
        "image": "assets/images/ara-8.jpg",
        "title": "냉장 쇼케이스",
        "location": "제주 제주시 아라동",
        "price": "80000",
        "likes": "3"
      },
      {
        "cid": "9",
        "image": "assets/images/ara-9.jpg",
        "title": "대우 미니냉장고",
        "location": "제주 제주시 아라동",
        "price": "30000",
        "likes": "3"
      },
      {
        "cid": "10",
        "image": "assets/images/ara-10.jpg",
        "title": "멜킨스 풀업 턱걸이 판매합니다.",
        "location": "제주 제주시 아라동",
        "price": "50000",
        "likes": "7"
      },
    ];
  }

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

  Widget bodyWidget() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      itemBuilder: (BuildContext context, int index) {
        return Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(children: [
              ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Image.asset(
                    datas[index]["image"]!,
                    width: 100,
                    height: 100,
                  )),
              Expanded(
                child: Container(
                    height: 100,
                    padding: const EdgeInsets.only(left: 20), //글자와 이미지 간격
                    // width: MediaQuery.of(context).size.width - 100, //연산은 가급적 피하자
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, //좌우

                        children: [
                          Text(
                            datas[index]["title"]!,
                            overflow: TextOverflow.ellipsis, //글자가 너무길어서 넘칠경우
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(height: 5),
                          Text(datas[index]["location"]!,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black.withOpacity(0.3),
                              )),
                          SizedBox(height: 5),
                          Text(
                            caclStringToWon(datas[index]["price"]!),
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end, //가로세로
                              crossAxisAlignment: CrossAxisAlignment.end,
                              // crossAxisAlignment:  // 위아래 ,
                              children: [
                                SvgPicture.asset(
                                  "assets/svg/heart_off.svg",
                                  width: 13,
                                  height: 13, // option + enter
                                ),
                                const SizedBox(width: 5),
                                Text(datas[index]["likes"]!)
                                // Padding(
                                //   padding: const EdgeInsets.only(left: 5), //only 오직 한군데만 넣기
                                //   child:,
                                // ),
                              ],
                            ),
                          ),
                        ])),
              ),
            ]));
        // 말그대로 아이템 ,
      },
      itemCount: 10,
      separatorBuilder: (BuildContext context, int index) {
        return Container(height: 1, color: Colors.black.withOpacity(0.4));
      },
    ); // 리스트 구분선
  }

  static final oCcy = new NumberFormat("#,###", "ko_KR");
  String caclStringToWon(String price) {
    return "${oCcy.format(int.parse(price))} 원";
  }

  BottomNavigationBarItem _bottomNavigationBarItem(
      String iconName, String label) {
    return BottomNavigationBarItem(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(),
      body: bodyWidget(),
      bottomNavigationBar: bottomNavigationBarWidget(),
    );
  }
}
