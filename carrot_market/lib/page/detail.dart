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

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }

  PreferredSizeWidget appBarWidget() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: const BackButton(
        color: Colors.black,
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share, color: Colors.black)),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more,
              color: Colors.black,
            )),
      ],
    );
  }

  Widget bodyWidget() {
    return Container(
      child: Hero(
          tag: widget.data["cid"] as String,
          child:
              Image.asset(widget.data["image"]!, width: 700, fit: BoxFit.fill)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // appbar뒤로가짐
      appBar: appBarWidget(),
      body: bodyWidget(),
    );
  }
}
