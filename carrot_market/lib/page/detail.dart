import 'package:carousel_slider/carousel_slider.dart';
import 'package:carrot_market/components/manor_temperature_widget.dart';
import 'package:carrot_market/page/app.dart';
import 'package:flutter/material.dart';

class DetailContentView extends StatefulWidget {
  //넘겨받을 타입

  Map<String, String> data;

  DetailContentView({super.key, required this.data});

  @override
  State<DetailContentView> createState() => _DetailContentViewState();
}

class _DetailContentViewState extends State<DetailContentView> {
  late Size size;

  late List<String> imgList;
  final CarouselController _controller = CarouselController();

  late int _current;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
    _current = 0;
    imgList = [
      widget.data['image'] as String,
      widget.data['image'] as String,
      widget.data['image'] as String,
      widget.data['image'] as String,
      widget.data['image']!,
    ];
  }

  PreferredSizeWidget appBarWidget() {
    return AppBar(
      elevation: 0, //선없애기

      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share, color: Colors.white)),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more,
              color: Colors.white,
            )),
      ],
    );
  }

  Widget _makeSlider() {
    return Container(
        child: Stack(
      //사진안으로 들어가기위해서 dot 부분이
      children: [
        Hero(
            //애니메이션효과
            tag: widget.data["cid"] as String,
            child: CarouselSlider(
              //카로셀
              options: CarouselOptions(
                  height: size.width,
                  initialPage: 0,
                  enableInfiniteScroll: false, //무한false
                  viewportFraction: 1, // 전체 사용
                  enlargeCenterPage: false,
                  onPageChanged: (index, reason) {
                    //dot
                    print(index);
                    setState(() {
                      _current = index;
                    });
                  }),
              items: imgList.map(
                (url) {
                  return Image.asset(url, width: size.width, fit: BoxFit.fill);
                },
              ).toList(),

              //
            )),
        Positioned(
          //사진안으로 들어가기위해서
          bottom: 0,
          left: 0, // left right 를 다 사용하겠다 .
          right: 0,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imgList.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 8.0,
                    height: 8.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.white.withOpacity(0.4))
                            .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                  ),
                );
              }).toList()),
        ),
      ],
    ));
  }

  Widget _sellerSimpleInfo() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          //첫번째달락

          CircleAvatar(
            //아바타
            radius: 25,
            backgroundImage: Image.asset("assets/images/user.png").image,
          ),
          const SizedBox(width: 10),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "개발하는 남자",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                "제주시 도달동",
              )
            ],
          ),
          Expanded(child: MannorTemperature(mannorTemp: 37.5)),
        ],
      ),
    );
  }

  Widget bodyWidget() {
    return CustomScrollView(slivers: [
      SliverList(
        delegate: SliverChildListDelegate(
          [
            _makeSlider(),
            _sellerSimpleInfo(),
            _line(),
            _contentsDetail(),
            _line(),
            _otherCellContents(),
          ],
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        sliver: SliverGrid(
          delegate: SliverChildListDelegate(List.generate(20, (index) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    child: Container(color: Colors.grey, height: 120),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  Text(
                    "상품제목",
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    "금액",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            );
          }).toList()),

          //grid
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //몇개씩ㅂ ㅗ여지고 , 간격 조절
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10),
        ),
      )
    ]);
  }

  Widget _otherCellContents() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "판매자님의 판매 상품",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Text(
            "모두보기",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget _contentsDetail() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15), //마진 혹은 패딩쓸때

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 15),
          Text(widget.data["title"] as String,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          Text("디지털/가전 - 22 시간 전 ",
              style: TextStyle(color: Colors.grey, fontSize: 12)),
          SizedBox(height: 15),
          Text("선물받은 새상품이고\n 상품 꺼내보기만 했습니다 \n거래는 직거래만 합니다.",
              style: TextStyle(height: 1.5, fontSize: 15)),
          SizedBox(height: 15),
          Text("채팅 3  관심 17 - 조회 295",
              style: TextStyle(color: Colors.grey, fontSize: 12)),
          SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget _line() {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      color: Colors.grey.withOpacity(0.3),
    );
    //각각에 대한 구분선
  }

  Widget BottomNavigationBarWidget() {
    return Container(
      width: size.width,
      height: 55,
      color: Colors.red,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // appbar뒤로가짐
      appBar: appBarWidget(),
      body: bodyWidget(),
      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }
}
