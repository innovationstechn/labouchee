import 'package:flutter/material.dart';
import 'package:labouchee/pages/home/category.dart';

import '../home/carousel_slider.dart';
import 'package:labouchee/pages/landing/landing_viewmodel.dart';
import 'package:stacked/stacked.dart';

class LandingView extends StatelessWidget {
  const LandingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewModelBuilder<LandingVM>.reactive(
        viewModelBuilder: () => LandingVM(),
        onModelReady: (model) => model.initialize(),
        builder: (context, landingVM, _) {
          if (landingVM.isBusy) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (landingVM.hasError) {
            return Center(
              child: Text(
                landingVM.error(landingVM),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    CarouselSlider(),
                    SizedBox(
                      height: 10,
                    ),
                    Category()
                  ]),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
