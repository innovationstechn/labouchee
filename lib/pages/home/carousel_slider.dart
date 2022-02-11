import 'package:flutter/cupertino.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class CarouselSlider extends StatefulWidget {

  const CarouselSlider({Key? key}) : super(key: key);

  @override
  _CarouselSliderState createState() => _CarouselSliderState();
}

class _CarouselSliderState extends State<CarouselSlider> {

  List<NetworkImage> images = [
    NetworkImage('https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
    NetworkImage('https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg'),
  ];


  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200.0,
        width: 350.0,
        child: Carousel(
          images: images,
          dotSize: 4.0,
          dotSpacing: 15.0,
          dotColor: Theme.of(context).primaryColor,
          indicatorBgPadding: 5.0,
          dotBgColor: Colors.black.withOpacity(0.5),
          borderRadius: true,
        )
    );
  }
}
