import 'package:carousel_slider/carousel_slider.dart';
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

  Widget bodyWidget() {
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
