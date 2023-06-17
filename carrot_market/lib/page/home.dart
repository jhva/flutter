import 'package:carrot_market/page/detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../repository/contents_repository.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String currentLocation;

  final ContentsRepository contentsRepository = ContentsRepository();

  final Map<String, String> locationTypeToString = {
    "ara": "아라동",
    "ora": "오라동",
    "donam": "도남동",
  };
  static final oCcy = new NumberFormat("#,###", "ko_KR");
  String caclStringToWon(String price) {
    if (price == "무료나눔") return price;
    return "${oCcy.format(int.parse(price))} 원";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    currentLocation = "ara";
  }

  PreferredSizeWidget appBarWidget() {
    return AppBar(
      title: GestureDetector(
        onTap: () {
          print('클릭');
        },
        child: PopupMenuButton<String>(
          offset: Offset(0, 30),
          shape: ShapeBorder.lerp(
              //팝업메뉴 border
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              1),
          onSelected: (String selected) {
            setState(() {
              currentLocation = selected;
            });
          },
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem(value: "ara", child: Text("아라동")),
              const PopupMenuItem(value: "ora", child: Text("오라동")),
              const PopupMenuItem(value: "donam", child: Text("도남동")),
            ];
          },
          child: Row(
            children: [
              Text(
                locationTypeToString[currentLocation]!,
                style: const TextStyle(color: Colors.black),
              ),
              const Icon(
                Icons.arrow_drop_down,
                color: Colors.black,
              ),
            ],
          ),
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

  _loadContents() {
    return contentsRepository.loadContentsFromLocation(currentLocation);
  }

  _makeDataList(List<Map<String, String>> datas) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            //페이지전환
            Navigator.push(context,
                //페이지이동
                MaterialPageRoute(builder: (BuildContext context) {
              return DetailContentView(data: datas[index]);
            }));
          },
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(children: [
                ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Hero(
                      //디테일로갈때 애니메이션 Hero tag 값을 넣어주면 받는쪽에서도 똑같이해줘야함
                      tag: datas[index]["cid"] as String,
                      child: Image.asset(
                        datas[index]["image"]!,
                        width: 100,
                        height: 100,
                      ),
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
              ])),
        );
        // 말그대로 아이템 ,
      },
      itemCount: 10,
      separatorBuilder: (BuildContext context, int index) {
        return Container(height: 1, color: Colors.black.withOpacity(0.4));
      },
    );
  }

  Widget bodyWidget() {
    return FutureBuilder(
        //언제올지 모르는 데이터를 위한
        future: _loadContents(),
        builder: (context, dynamic snapshot) {
          print(snapshot);
          //클래스를 만들었을때 바로 접근해서사용할때 snapshot
          // snapshot은 null을 체크해줄수가있다.

          if (snapshot.connectionState != ConnectionState.done) {
            //아직안불러왔다면 , 로딩창
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            return _makeDataList(snapshot?.data);
          }
          //데이터없을때
          return Center(child: Text("데이터없당"));
          // / 리스트 구분선
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(),
      body: bodyWidget(),
    );
  }
}
