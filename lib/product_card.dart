import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labouchee/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/locator.dart';
import 'app/routes.gr.dart';
import 'models/product.dart';
import 'services/navigator.dart';

class ProductCard extends StatelessWidget {
  final int selectedItemIndex;
  final List<ProductModel> similarModel;
  final bool isSmall;
  final bool disableOnTap;
  final NavigatorService _navigationService = locator<NavigatorService>();

  ProductCard(
      {Key? key,
      required this.selectedItemIndex,
      required this.isSmall,
      required this.similarModel,
      this.disableOnTap = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productModel = similarModel[selectedItemIndex];
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor, width: 1),
        borderRadius: BorderRadius.all(const Radius.circular(3)),
      ),
      child: GestureDetector(
        onTap: () => disableOnTap
            ? null
            : _navigationService.router.navigate(
          ProductScreenRoute(
              selectedIndex: selectedItemIndex,
              similarProducts: similarModel),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              flex: 4,
              child: SizedBox.expand(
                child: Image.network(
                  productModel.images!.elementAt(0),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: FittedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      text: productModel.name,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                    ),
                    CustomText(
                        text: productModel.price.toString(),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                        padding: EdgeInsets.symmetric(horizontal: 5)),
                    // SizedBox(height: 10,),
                  ],
                ),
              ),
            ),
            // Spacer(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  LayoutBuilder(builder: (context, constraints) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FittedBox(
                          child: RatingBarIndicator(
                            itemBuilder: (_, __) => const Icon(
                              Icons.star,
                              color: Color(0xffDE970B),
                            ),
                            rating: productModel.productRating ?? 0,
                            itemSize: 0.12 * constraints.maxWidth,
                            unratedColor: Colors.grey[300],
                          ),
                        ),
                        Icon(
                          Icons.shopping_cart,
                          size: constraints.maxWidth * 0.15,
                        ),
                      ],
                    );
                  }),
                  // const SizedBox(height: 10)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
