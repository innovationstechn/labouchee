import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:getwidget/components/carousel/gf_items_carousel.dart';
import 'package:labouchee/models/product.dart';
import 'package:labouchee/widgets/category.dart';
import 'package:labouchee/services/navigator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:labouchee/widgets/custom_cached_image.dart';
import 'package:sizer/sizer.dart';
import '../../app/locator.dart';
import '../../app/routes.gr.dart';
import '../../models/product.dart';

import 'package:labouchee/pages/landing/landing_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/custom_circular_progress_indicator.dart';
import '../../widgets/custom_text.dart';

class LandingView extends StatefulWidget {
  const LandingView({Key? key}) : super(key: key);

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  final NavigatorService _navigationService = locator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ViewModelBuilder<LandingVM>.reactive(
          viewModelBuilder: () => LandingVM(),
          onModelReady: (model) => model.initialize(),
          builder: (context, landingVM, _) {
            if (landingVM.isBusy) {
              return const Center(
                child: CustomCircularProgressIndicator(),
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
                  child: LayoutBuilder(builder: (context, constraints) {
                    final int hItemCount = constraints.maxWidth.round() ~/ 150;

                    return SingleChildScrollView(
                      child: Column(
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
                                      child: CustomCachedImage(
                                        image: e.photo!,
                                        boxFit: BoxFit.cover,
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
                                        child: buildCategoryCapsule(
                                            AppLocalizations.of(context)!
                                                .featured),
                                      ),
                                      Tab(
                                        child: buildCategoryCapsule(
                                            AppLocalizations.of(context)!
                                                .hotSale),
                                      ),
                                      Tab(
                                        child: buildCategoryCapsule(
                                            AppLocalizations.of(context)!
                                                .viewed),
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
                          Category(
                            categories: landingVM.categories,
                            constraints: constraints,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                buildCategoryCapsule(
                                    AppLocalizations.of(context)!.ourCatalog),
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
                                  return productCard(
                                      index, landingVM, landingVM.products);
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
                      ),
                    );
                  })),
            );
          },
        ),
      ),
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
                  child: GestureDetector(
                    onTap: () {
                      _navigationService.router.navigate(
                        ProductScreenRoute(
                            selectedIndex: products.indexOf(item),
                            similarProducts: products),
                      );
                    },
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                      child: SizedBox(
                        width: 1000.0,
                        child: CustomCachedImage(
                          image: item.images!.first,
                          boxFit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }

  Widget productCard(int selectedIndex, LandingVM landingVM,
      List<ProductModel> similarProduct) {
    final item = similarProduct[selectedIndex];
    return GestureDetector(
      onTap: () {
        landingVM.goToProductDetailPage(selectedIndex, similarProduct);
      },
      child: Container(
        constraints: const BoxConstraints(maxWidth: 300),
        margin: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    item.name!,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Text(
                  similarProduct[selectedIndex]
                          .productRating
                          ?.toStringAsFixed(1) ??
                      "-",
                  style:
                      TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
                ),
                Icon(
                  Icons.star,
                  color: Colors.yellow[700],
                  size: 13.sp,
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: AspectRatio(
                aspectRatio: 3 / 2,
                child: CustomCachedImage(
                  image: similarProduct[selectedIndex].images!.first,
                  boxFit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            LayoutBuilder(builder: (context, constraints) {
              return Wrap(
                children: [
                  if (item.priceSmall != null)
                    buildSizeCapsule(AppLocalizations.of(context)!.small),
                  if (item.priceMedium != null)
                    buildSizeCapsule(AppLocalizations.of(context)!.medium),
                  if (item.priceLarge != null)
                    buildSizeCapsule(AppLocalizations.of(context)!.large),
                ],
              );
            }),
            const SizedBox(
              height: 10,
            ),
            CustomText(
              text: item.description,
              maxLines: 3,
              fontSize: 13.sp,
            )
            // const Divider()
          ],
        ),
      ),
    );
  }

  Widget buildCategoryCapsule(String name, {Color? color}) {
    return Builder(builder: (context) {
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
              style: TextStyle(color: Colors.white, fontSize: 12.sp),
            ),
          ),
        ),
      );
    });
  }

  Widget buildSizeCapsule(String name) {
    return Builder(builder: (context) {
      return FittedBox(
        child: Container(
          margin: const EdgeInsets.only(right: 10, top: 10),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          height: 25,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Align(
            alignment: Alignment.center,
            child: FittedBox(
              child: CustomText(
                text: name,
                color: Colors.white,
                fontSize: 11.sp,
                // style: const TextStyle(),
              ),
            ),
          ),
        ),
      );
    });
  }
}
