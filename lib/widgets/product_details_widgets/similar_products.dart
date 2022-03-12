import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';
import '../../app/locator.dart';
import '../../app/routes.gr.dart';
import '../../models/product.dart';
import '../../product_card.dart';
import '../../services/navigator.dart';
import '../custom_text.dart';

class SimilarProducts extends StatelessWidget {
  final List<ProductModel> similarProducts;
  final int selectedIndex;
  final _navigationService = locator<NavigatorService>();
  SimilarProducts(
      {Key? key, required this.similarProducts, required this.selectedIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, boxConstraints) {
      double boxHeight =
          boxConstraints.maxHeight * 0.65 > boxConstraints.maxWidth * 0.4
              ? boxConstraints.maxWidth * 0.5
              : boxConstraints.maxHeight * 0.65;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: AppLocalizations.of(context)?.similarProducts,
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: boxHeight,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: similarProducts.length,
              itemBuilder: (context, index) {
                return index == selectedIndex
                    ? Container()
                    : Container(
                        width: boxConstraints.maxWidth * 0.4,
                        padding: const EdgeInsetsDirectional.only(end: 10),
                        child: ProductCard(
                          onTap: () {
                            _navigationService.router.popAndPush(
                              ProductScreenRoute(
                                  selectedIndex: index,
                                  similarProducts: similarProducts),
                            );
                          },
                          isSmall: false,
                          selectedItemIndex: index,
                          similarModel: similarProducts,
                        ),
                      );
              },
            ),
          ),
        ],
      );
    });
  }
}
