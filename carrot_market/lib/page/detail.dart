import 'package:carousel_slider/carousel_slider.dart';
import 'package:carrot_market/components/manor_temperature_widget.dart';
import 'package:carrot_market/page/app.dart';
import 'package:carrot_market/utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailContentView extends StatefulWidget {
  //넘겨받을 타입

  Map<String, String> data;

  DetailContentView({super.key, required this.data});

  @override
  State<DetailContentView> createState() => _DetailContentViewState();
}

class _DetailContentViewState extends State<DetailContentView>
    with
//animation vsync this오류 잡을려고
        SingleTickerProviderStateMixin {
  late Size size;

  late List<String> imgList;
  late double scrollpositorionToAlpha = 0;
  final CarouselController _controller = CarouselController();

  ScrollController scrollController = ScrollController();

  late AnimationController _animationController;
  late Animation _colorTween;

  late bool isMyFavoriteContent; // 관심상품 등록

  late final GlobalKey<ScaffoldMessengerState> scaffoldMessage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isMyFavoriteContent = false;
    scaffoldMessage = GlobalKey<ScaffoldMessengerState>();

    _animationController = AnimationController(vsync: this);
    _colorTween = ColorTween(begin: Colors.white, end: Colors.black)
        .animate(_animationController);
    scrollController.addListener(() {
      //scroll 이 변활때마다 찍히게됨

      setState(() {
        if (scrollController.offset > 255) {
          scrollpositorionToAlpha = 255;
        } else {
          scrollpositorionToAlpha = scrollController.offset; //scroll 위치
        }
        _animationController.value = scrollpositorionToAlpha / 255;
      });
    });
  }

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

      backgroundColor: Colors.white.withAlpha(scrollpositorionToAlpha.toInt()),
      leading: IconButton(
        icon: _makeIcon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        IconButton(onPressed: () {}, icon: _makeIcon(Icons.share)),
        IconButton(onPressed: () {}, icon: _makeIcon(Icons.more)),
      ],
    );
  }

  Widget _makeIcon(IconData icon) {
    return AnimatedBuilder(
        animation: _colorTween,
        builder: (context, child) => Icon(
              icon,
              color: _colorTween.value,
            ));
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
    return CustomScrollView(controller: scrollController, slivers: [
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
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: 55,
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isMyFavoriteContent = !isMyFavoriteContent;
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    duration: const Duration(milliseconds: 1000),
                    content: Text(isMyFavoriteContent
                        ? "관심목록에 추가됐어요."
                        : "관심목록에서 제거됐어요.")));
                // scaffoldMessage?.currentState?.showSnackBar(SnackBar(
                //   duration: const Duration(milliseconds: 1000),
                //   content: Text(
                //       isMyFavoriteContent ? "관심목록에 추가됐어요." : "관심목록에서 제거됐어요."),
                // ));
              },
              child: SvgPicture.asset(
                isMyFavoriteContent
                    ? "assets/svg/heart_on.svg"
                    : "assets/"
                        "svg/heart_off.svg",
                width: 25,
                height: 24,
                color: const Color(0xfff08f4f),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 10),
              width: 1,
              height: 40,
              color: Colors.grey.withOpacity(0.3),
            ),
            Column(
              children: [
                Text(
                  DetailUtils.caclStringToWon(widget.data["price"]!),
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                Text(
                  "가격제안불가",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                )
              ],
            ),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xfff09f4f),
                  ),
                  child: Text(
                    "채팅으로 거래하기",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ))
          ],
        ));
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
