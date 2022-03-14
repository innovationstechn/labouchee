import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labouchee/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'app/locator.dart';
import 'app/routes.gr.dart';
import 'models/product.dart';
import 'services/navigator.dart';

class ProductCard extends StatelessWidget {
  final int selectedItemIndex;
  final List<ProductModel> similarModel;
  final bool isSmall;
  final Function? onTap;
  final NavigatorService _navigationService = locator<NavigatorService>();

  ProductCard(
      {Key? key,
      required this.selectedItemIndex,
      required this.isSmall,
      required this.similarModel,
      this.onTap})
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
        onTap: () => onTap != null
            ? onTap!()
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
              flex: 2,
              child: FittedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    CustomText(
                      text: productModel.name,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                    ),
                    CustomText(
                        text: generatePrice(productModel).toString() +
                            " " +
                            AppLocalizations.of(context)!.currency,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5)),
                  ],
                ),
              ),
            ),
            // Spacer(),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RatingBarIndicator(
                    itemBuilder: (_, __) => const Icon(
                      Icons.star,
                      color: Color(0xffDE970B),
                    ),
                    rating: productModel.productRating ?? 0,
                    itemSize: 15.sp,
                    unratedColor: Colors.grey[300],
                  ),
                  FittedBox(
                    child: Icon(
                      Icons.shopping_cart,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double generatePrice(ProductModel product) {
    return product.price ??
        product.priceSmall ??
        product.priceMedium ??
        product.priceLarge ??
        0.0;
  }
}
