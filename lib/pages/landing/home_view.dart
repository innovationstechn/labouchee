import 'package:flutter/material.dart';
import 'package:labouchee/landing_products_list.dart';
import 'package:labouchee/pages/home/category.dart';
import 'package:labouchee/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

import '../../models/product.dart';
import '../home/carousel_slider.dart';
import 'package:labouchee/pages/landing/landing_viewmodel.dart';
import 'package:stacked/stacked.dart';

class LandingView extends StatelessWidget {
  LandingView({Key? key}) : super(key: key);
  final List<ProductModel> productModel = [
    ProductModel(
        name: "Umer",
        price: 10,
        images: [
          "https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg"
        ],
        productRating: 2),
    ProductModel(
        name: "Umer",
        price: 10,
        images: [
          "https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg"
        ],
        productRating: 2),
    ProductModel(
        name: "Umer",
        price: 10,
        images: [
          "https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg"
        ],
        productRating: 2),
    ProductModel(
        name: "Umer",
        price: 10,
        images: [
          "https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg"
        ],
        productRating: 2),
  ];

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "Categories",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        ),
                        CustomText(
                          text: "All Categories",
                          fontSize: 11.sp,
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context).primaryColor,
                          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        ),
                      ],
                    ),
                    Category(),
                    SizedBox(
                      height: 20,
                    ),
                    CarouselSlider(),
                    SizedBox(
                      height: 10,
                    ),
                  ]),
                ),
                LandingProductList(items: productModel),
              ],
            ),
          );
        },
      ),
    );
  }
}
