import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labouchee/models/cart_item.dart';
import 'package:labouchee/pages/cart/cart_viewmodel.dart';
import 'package:labouchee/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';
import 'package:sdk/components/network_helper.dart';
import 'package:sdk/screens/webview_screen.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:xml/xml.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import '../../app/locator.dart';
import '../../app/routes.gr.dart';
import '../../models/cart.dart';
import '../../services/api/labouchee_api.dart';
import '../../widgets/custom_button.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  final _laboucheeAPI = locator<LaboucheeAPI>();
  final _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CartVM>.reactive(
      viewModelBuilder: () => CartVM(),
      onModelReady: (model) => model.sync(),
      builder: (context, cartVM, _) {
        if (cartVM.isBusy) return Center(child: CircularProgressIndicator());

        return LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                Container(
                  height: constraints.maxHeight - 60,
                  child: StreamBuilder(
                    stream: cartVM.cart,
                    builder: (BuildContext context,
                        AsyncSnapshot<CartModel> snapshot) {
                      if (!snapshot.hasData) return CircularProgressIndicator();

                      return ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
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
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                CustomButton(
                  size: Size(constraints.maxWidth * 0.9, 40),
                  text: "CHECK OUT",
                  textFontSize: 14.sp,
                  // circularSize: 20,
                  onTap: () {
                    _navigationService.navigateTo(Routes.checkoutScreenRoute);
                  },
                )
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
                        child: SizedBox.expand(
                          child: Image.network(
                            item.image!,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: constraints.maxWidth * 0.65,
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
                            text: e.type!,
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
                                  text: "\$ ${e.price}",
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 1),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(25.0),
                                        ),
                                        border: Border.all(
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.add,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: 18.sp,
                                            ),
                                            onPressed: () => vm.increase(
                                              item.id!,
                                              1,
                                              e.type!,
                                            ),
                                          ),
                                          CustomText(
                                            text:
                                                e.quantity!.toString(),
                                            fontSize: 14.sp,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 3,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () => vm.decrease(
                                              item.id!,
                                              1,
                                              e.type!,
                                            ),
                                            icon: Icon(
                                              Icons.remove,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: 18.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    IconButton(
                                      onPressed: () => vm.remove(item, e.type!),
                                      icon: Icon(
                                        Icons.delete,
                                        color: Theme.of(context).primaryColor,
                                        size: 20.sp,
                                      ),
                                    ),
                                  ],
                                ),
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
}
