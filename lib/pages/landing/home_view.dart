import 'package:flutter/material.dart';
import 'package:labouchee/pages/home/category.dart';

import '../home/carousel_slider.dart';

class LandingView extends StatelessWidget {
  const LandingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                CarouselSlider(),
                SizedBox(height: 10,),
                Category()
              ]
              ),
            ),
          ],
        )
      ),
    );
  }
}
