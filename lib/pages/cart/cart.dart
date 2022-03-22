import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labouchee/models/cart_item.dart';
import 'package:labouchee/pages/cart/cart_viewmodel.dart';
import 'package:labouchee/widgets/custom_cached_image.dart';
import 'package:labouchee/widgets/custom_circular_progress_indicator.dart';
import 'package:labouchee/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/locator.dart';
import '../../app/routes.gr.dart';
import '../../models/cart.dart';
import '../../services/navigator.dart';
import '../../widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  final _navigationService = locator<NavigatorService>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CartVM>.reactive(
      viewModelBuilder: () => CartVM(),
      onModelReady: (model) => model.sync(),
      builder: (context, cartVM, _) {
        if (cartVM.isBusy) {
          return const Center(child: CustomCircularProgressIndicator());
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder(
                  stream: cartVM.cart,
                  builder: (BuildContext context,
                      AsyncSnapshot<CartModel> snapshot) {
                    if (!snapshot.hasData)
                      return CustomCircularProgressIndicator();

                    if (snapshot.data!.items!.isEmpty) {
                      return Center(
                        child: CustomText(
                          text: AppLocalizations.of(context)!.cartIsEmpty,
                          fontSize: 12.sp,
                        ),
                      );
                    }

                    return Column(
                      children: [
                        Container(
                          height: constraints.maxHeight - 60,
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding:
                                const EdgeInsets.only(bottom: 8.0, top: 8.0),
                            itemCount: snapshot.data?.items?.length ?? 0,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  displayCard(
                                    snapshot.data!.items!.elementAt(index),
                                    constraints,
                                    cartVM,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Divider(
                                      thickness: 1.0,
                                      color: Colors.black12,
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        CustomButton(
                          size: Size(constraints.maxWidth * 0.9, 40),
                          text: AppLocalizations.of(context)!.checkOUT,
                          textFontSize: 14.sp,
                          // circularSize: 20,
                          onTap: () {
                            _navigationService.router
                                .navigate(CheckoutScreenRoute());
                          },
                        )
                      ],
                    );
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget displayCard(
      CartItemModel item, BoxConstraints constraints, CartVM vm) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...?item.size
            ?.map(
              (e) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: constraints.maxWidth * 0.25,
                      height: constraints.maxWidth * 0.28,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        child: CustomCachedImage(image: item.image!),
                      ),
                    ),
                    Container(
                      width: constraints.maxWidth * 0.7,
                      height: constraints.maxWidth * 0.28,
                      padding: const EdgeInsetsDirectional.only(start: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: item.title!,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          CustomText(
                            text: convertText(e.type!),
                            color: Colors.black38,
                            fontSize: 14.sp,
                            maxLines: 2,
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: "${e.price}" +
                                      " " +
                                      AppLocalizations.of(context)!.currency,
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  padding:
                                      EdgeInsetsDirectional.only(bottom: 5),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      // height: 25,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(25.0),
                                        ),
                                        border: Border.all(
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () => vm.increase(
                                              item.id!,
                                              1,
                                              convertText(e.type!) ?? "",
                                            ),
                                            child: Icon(
                                              Icons.add,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: 18.sp,
                                            ),
                                          ),
                                          CustomText(
                                            text: e.quantity!.toString(),
                                            fontSize: 14.sp,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 4,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () => vm.decrease(
                                              item.id!,
                                              1,
                                              e.type!,
                                            ),
                                            child: Icon(
                                              Icons.remove,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: 18.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    InkWell(
                                      onTap: () => vm.remove(item, e.type!),
                                      child: Icon(
                                        Icons.delete,
                                        color: Theme.of(context).primaryColor,
                                        size: 20.sp,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ],
    );
  }

  String? convertText(String text) {
    switch (text) {
      case 'sm':
        return AppLocalizations.of(context)!.small;
      case 'md':
        return AppLocalizations.of(context)!.medium;
      case 'lg':
        return AppLocalizations.of(context)!.large;
      default:
        return text.capitalize;
    }
  }
}
