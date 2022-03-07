import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labouchee/models/cart_detail.dart';
import 'package:labouchee/models/cart_item.dart';
import 'package:labouchee/pages/checkout/checkout_viewmodel.dart';
import 'package:labouchee/widgets/custom_app_bar.dart';
import 'package:labouchee/widgets/custom_button.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/locator.dart';
import '../../app/routes.gr.dart';
import '../../models/TelrPaymentModel.dart';
import '../../services/navigator.dart';
import '../../widgets/custom_text.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({Key? key}) : super(key: key);

  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  PanelController panelController = PanelController();
  final _navigationService = locator<NavigatorService>();
  late BoxConstraints boxConstraints;
  bool disableSlidingUI = true;
  final TextEditingController couponTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      boxConstraints = constraints;
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 50,
            leading: const BackButton(color: Colors.black),
            title: CustomText(
              text: "Check Out",
              fontWeight: FontWeight.bold,
              fontSize: 15.sp,
            ),
            titleTextStyle: const TextStyle(color: Colors.black),
            backgroundColor: Colors.white,
          ),
          body: ViewModelBuilder<CheckoutVM>.reactive(
              viewModelBuilder: () => CheckoutVM(),
              onModelReady: (model) => model.initialize(),
              builder: (context, checkoutVM, _) {
                if (checkoutVM.isBusy) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Stack(
                  children: [
                    SizedBox(
                      height: constraints.maxHeight - 320,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return displayProduct(constraints,
                              checkoutVM.details!.cart!.items![index]);
                        },
                        itemCount: checkoutVM.details!.cart!.items!.length,
                      ),
                    ),
                    SlidingUpPanel(
                      controller: panelController,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(18.0),
                          topRight: Radius.circular(18.0)),
                      maxHeight: 240,
                      minHeight: 240,
                      panelBuilder: (sc) =>
                          _panel(sc, checkoutVM.details!.cartInfo!, checkoutVM),
                      onPanelSlide: (double pos) => setState(() {
                        print("Position:" + pos.toString());
                      }),
                    )
                  ],
                );
              }),
        ),
      );
    });
  }

  Widget _panel(ScrollController controller, CartDetailInfoModel info,
      CheckoutVM checkoutVM) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 190,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsetsDirectional.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 30,
                      height: 5,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.0))),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                if(disableSlidingUI && (checkoutVM.details?.cartInfo?.discountAmount ?? -1) <= 0 )
                     Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: "Have you a coupon code?",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.normal,
                          ),
                          CustomText(
                            text: "APPLY COUPON",
                            color: Theme.of(context).primaryColor,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.normal,
                            onTap:(){
                              disableSlidingUI = false;
                              checkoutVM.notifyListeners();
                            }
                          ),
                        ],
                      ),
                if (!disableSlidingUI && (checkoutVM.details?.cartInfo?.discountAmount ?? -1) <= 0)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side:
                              BorderSide(color: Theme.of(context).primaryColor),
                        ),
                        child: SizedBox(
                          width: boxConstraints.maxWidth * 0.72,
                          height: 40,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: TextFormField(
                              controller: couponTextController,
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  letterSpacing: 1.0,
                                  height: 1.5),
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration.collapsed(
                                hintText: "Enter your coupon code",
                                hintStyle: TextStyle(
                                    // color: Theme.of(context).primaryColor,
                                    fontSize: 14.sp),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      CustomButton(
                        text: "APPLY",
                        textColor: Colors.white,
                        buttonColor: Theme.of(context).primaryColor,
                        textFontSize: 10.sp,
                        size: Size(boxConstraints.maxWidth * 0.2, 35),
                        onTap: () {
                          checkoutVM.applyCoupon(couponTextController.text);
                        },
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "Coupon Off:",
                      fontSize: 12.sp,
                      // fontWeight:,
                    ),
                    CustomText(
                      text: "SAR ${info.discountAmount?.toString() ?? 0}",
                      fontSize: 13.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "Shipping Cost:",
                      fontSize: 12.sp,
                    ),
                    CustomText(
                      text: "SAR ${info.shipping?.toString() ?? 0}",
                      fontSize: 13.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "Total Cost:",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        text: "SAR ${info.totalPrice?.toString() ?? '?'}",
                        fontSize: 13.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        CustomButton(
          size: const Size(double.infinity, 50),
          text: "PAY SAR ${info.totalPrice?.toString() ?? '?'}",
          textFontSize: 14.sp,
          // circularSize: 20,
          onTap: () {
            _navigationService.router.navigate(
              PlaceOrderScreenRoute(),
            );
          },
        ),
      ],
    );
  }

  Widget displayProduct(BoxConstraints constraints, CartItemModel item) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...?item.size
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
                            child: SizedBox.expand(
                              child: Image.network(
                                item.image!,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            CustomText(
                              text: item.totalAmount.toString(),
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
                      text: item.title!,
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
