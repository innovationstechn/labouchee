import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labouchee/landing_products_list.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:getwidget/components/carousel/gf_items_carousel.dart';
import 'package:getwidget/components/tabs/gf_tabbar.dart';
import 'package:getwidget/components/tabs/gf_tabbar_view.dart';
import 'package:labouchee/models/product.dart';
import 'package:labouchee/pages/home/category.dart';
import 'package:labouchee/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

import '../../models/product.dart';
import '../home/carousel_slider.dart';
import 'package:labouchee/pages/landing/landing_viewmodel.dart';
import 'package:stacked/stacked.dart';

class LandingView extends StatelessWidget {
  LandingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ViewModelBuilder<LandingVM>.reactive(
          viewModelBuilder: () => LandingVM(),
          onModelReady: (model) => model.initialize(),
          builder: (context, landingVM, _) {
            if (landingVM.isBusy) {
              return Center(
                child: CircularProgressIndicator(color:Theme.of(context).primaryColor),
              );
            } else if (landingVM.hasError) {
              return Center(
                child: Text(
                  landingVM.error(landingVM),
                ),
              );
            }

            return Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 800),
                child: SingleChildScrollView(
                  child: LayoutBuilder(builder: (context, constraints) {
                    final int hItemCount = constraints.maxWidth.round() ~/ 150;

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: GFCarousel(
                            hasPagination: true,
                            passiveIndicator: Colors.white.withAlpha(100),
                            activeIndicator: Colors.white.withAlpha(200),
                            viewportFraction: 1.0,
                            autoPlay: true,
                            enableInfiniteScroll: true,
                            items: landingVM.banners
                                .map(
                                  (e) => ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5.0)),
                                    child: Image.network(
                                      e.photo!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        DefaultTabController(
                          length: 3,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 50,
                                child: TabBar(
                                  unselectedLabelColor: Colors.redAccent,
                                  indicatorSize: TabBarIndicatorSize.label,
                                  indicator: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      ),
                                  tabs: [
                                    Tab(
                                      child: buildCategoryCapsule('FEATURED'),
                                    ),
                                    Tab(
                                      child: buildCategoryCapsule('HOT SALE'),
                                    ),
                                    Tab(
                                      child: buildCategoryCapsule('VIEWED'),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 220,
                                child: TabBarView(children: [
                                  buildTab(landingVM.featured, hItemCount),
                                  buildTab(landingVM.hotSale, hItemCount),
                                  buildTab(landingVM.mostViewed, hItemCount),
                                ]),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              buildCategoryCapsule('OUR CATALOG'),
                            ],
                          ),
                        ),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            return AlignedGridView.count(
                              itemCount: landingVM.products.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                final item = landingVM.products[index];

                                return productCard(item);
                              },
                              crossAxisCount:
                                  constraints.maxWidth > 400 ? 2 : 1,
                            );
                          },
                        ),
                        // ListView.builder(
                        //   physics: const NeverScrollableScrollPhysics(),
                        //   shrinkWrap: true,
                        //   itemCount: landingVM.products.length,
                        //   itemBuilder: (context, index) {
                        //     final item = landingVM.products[index];
                        //
                        //     return productCard(item);
                        //   },
                        // )
                      ],
                    );
                  }),
                ),
              ),
            );
          },
        ),
      ),
      //
      //     return Padding(
      //       padding: const EdgeInsets.all(10.0),
      //       child: CustomScrollView(
      //         slivers: [
      //           SliverList(
      //             delegate: SliverChildListDelegate([
      //               CarouselSlider(),
      //               SizedBox(
      //                 height: 10,
      //               ),
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   CustomText(
      //                     text: "Categories",
      //                     fontSize: 14.sp,
      //                     fontWeight: FontWeight.bold,
      //                     padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      //                   ),
      //                   CustomText(
      //                     text: "All Categories",
      //                     fontSize: 11.sp,
      //                     fontWeight: FontWeight.normal,
      //                     color: Theme.of(context).primaryColor,
      //                     padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      //                   ),
      //                 ],
      //               ),
      //               Category(),
      //               SizedBox(
      //                 height: 20,
      //               ),
      //               CarouselSlider(),
      //               SizedBox(
      //                 height: 10,
      //               ),
      //             ]),
      //           ),
      //           LandingProductList(items: productModel),
      //         ],
      //     },
      //   ),
      // ),
    );
  }

  Widget buildTab(List<ProductModel> products, int hItemCount) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GFItemsCarousel(
            rowCount: hItemCount,
            children: products.map(
              (item) {
                return Container(
                  margin: const EdgeInsets.all(4),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    child: Image.network(item.images!.first,
                        fit: BoxFit.cover, width: 1000.0),
                  ),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }

  // Mughe is wkt wo meme yaad aa rahi jis ma banda bus khali hath hila raha hota ha or dosre kaam kar rahe hote. :XD
  // Meri halat wo hath hilane wali ha Koi mal

  Widget productCard(ProductModel item) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      margin: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                item.name!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Spacer(),
              Text(
                item.productRating?.toStringAsFixed(1) ?? "-",
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              Icon(
                Icons.star,
                color: Colors.yellow[700],
                size: 18,
              )
            ],
          ),

          const SizedBox(
            height: 10,
          ),
          LayoutBuilder(builder: (context, constraints) {
            return ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: Image.network(
                item.images!.first,
                fit: BoxFit.cover,
              ),
            );
          }),
          // LayoutBuilder(
          //   builder: (context, constraints) {
          //     return Wrap(
          //       crossAxisAlignment: WrapCrossAlignment.center,
          //       alignment: WrapAlignment.center,
          //       children: item.images!
          //           .map(
          //             (e) => Container(
          //               width: constraints.maxWidth < 500 ? double.infinity : 250,
          //               margin: const EdgeInsets.all(4),
          //               child: ClipRRect(
          //                 borderRadius:
          //                     const BorderRadius.all(Radius.circular(5.0)),
          //                 child: Image.network(
          //                   e,
          //                   fit: BoxFit.cover,
          //                 ),
          //               ),
          //             ),
          //           )
          //           .toList(),
          //     );
          //   }
          // ),

          const SizedBox(
            height: 10,
          ),
          LayoutBuilder(builder: (context, constraints) {
            return SizedBox(
              width: constraints.maxWidth,
              child: Row(
                children: [
                  if (item.priceSmall != null) buildSizeCapsule('SMALL'),
                  if (item.priceMedium != null) buildSizeCapsule('MEDIUM'),
                  if (item.priceLarge != null) buildSizeCapsule('LARGE'),
                ],
              ),
            );
          }),
          const SizedBox(
            height: 10,
          ),
          Text(
            item.description!,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          // const Divider()
        ],
      ),
    );
  }

  Widget buildCategoryCapsule(String name, {Color? color}) {
    return Builder(
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          height: 50,
          decoration: BoxDecoration(
              color: color ?? Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(50)),
          child: Align(
            alignment: Alignment.center,
            child: FittedBox(
              child: Text(
                name,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      }
    );
  }

  Widget buildSizeCapsule(String name) {
    return Builder(
      builder: (context) {
        return FittedBox(
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            height: 25,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Align(
              alignment: Alignment.center,
              child: FittedBox(
                child: Text(
                  name,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
