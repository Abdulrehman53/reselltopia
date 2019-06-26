import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class SlideBar extends StatefulWidget {
  @override
  _SlideBarState createState() => _SlideBarState();
}

class _SlideBarState extends State<SlideBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('images/photo1.jpeg'),
          AssetImage('images/photo2.jpeg'),
          AssetImage('images/photo3.jpeg'),
          AssetImage('images/photo4.jpeg')
        ],
        autoplay: true,
        dotSize: 4.0,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(microseconds: 1000),
        indicatorBgPadding: 8.0,
      ),
    );
  }
}
