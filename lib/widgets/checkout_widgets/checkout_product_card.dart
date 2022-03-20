import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labouchee/models/cart_item.dart';
import 'package:labouchee/pages/checkout/checkout_viewmodel.dart';
import 'package:labouchee/widgets/custom_cached_image.dart';
import 'package:sizer/sizer.dart';
import '../../widgets/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CheckoutProducts extends StatelessWidget {
  final BoxConstraints constraints;
  final CheckoutVM checkoutVM;

  const CheckoutProducts(
      {Key? key, required this.constraints, required this.checkoutVM})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return checkOutProductCard(
            context, checkoutVM.details!.cart!.items![index]);
      },
      itemCount: checkoutVM.details!.cart!.items!.length,
    );
  }

  Widget checkOutProductCard(
      BuildContext context, CartItemModel cartItemModel) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...?cartItemModel.size
            ?.map(
              (e) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: constraints.maxWidth * 0.25,
                          height: constraints.maxWidth * 0.2,
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            child: CustomCachedImage(
                              image: cartItemModel.image!,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            CustomText(
                              text: e.price.toString() +
                                  " " +
                                  AppLocalizations.of(context)!.currency,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 1),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(25.0),
                                ),
                                border: Border.all(
                                    color: Theme.of(context).primaryColor),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: Theme.of(context).primaryColor,
                                    size: 18.sp,
                                  ),
                                  CustomText(
                                    text: e.quantity!.toString(),
                                    fontSize: 14.sp,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 3,
                                    ),
                                  ),
                                  Icon(
                                    Icons.remove,
                                    color: Theme.of(context).primaryColor,
                                    size: 18.sp,
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    CustomText(
                      padding: const EdgeInsetsDirectional.only(top: 10),
                      text: cartItemModel.title!,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 10),
                    Divider(
                      color: Theme.of(context).primaryColor,
                      thickness: 2,
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ],
    );
  }
}
