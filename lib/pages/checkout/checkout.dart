import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labouchee/models/cart_detail.dart';
import 'package:labouchee/pages/checkout/checkout_viewmodel.dart';
import 'package:labouchee/widgets/checkout_widgets/checkout_product_card.dart';
import 'package:labouchee/widgets/custom_app_bar.dart';
import 'package:labouchee/widgets/custom_button.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:stacked/stacked.dart';
import '../../app/locator.dart';
import '../../app/routes.gr.dart';
import '../../services/navigator.dart';
import '../../widgets/checkout_widgets/apply_coupon.dart';
import '../../widgets/custom_circular_progress_indicator.dart';
import '../../widgets/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      boxConstraints = constraints;
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: AppLocalizations.of(context)!.checkOUT,
        ),
        body: ViewModelBuilder<CheckoutVM>.reactive(
            viewModelBuilder: () => CheckoutVM(),
            onModelReady: (model) => model.initialize(),
            builder: (context, checkoutVM, _) {
              if (checkoutVM.isBusy) {
                return const Center(
                  child: CustomCircularProgressIndicator(),
                );
              }
              return Stack(
                children: [
                  SizedBox(
                    height: constraints.maxHeight * 0.72,
                    child: CheckoutProducts(
                      constraints: constraints,
                      checkoutVM: checkoutVM,
                    ),
                  ),
                  SlidingUpPanel(
                    controller: panelController,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(18.0),
                        topRight: Radius.circular(18.0)),
                    maxHeight: constraints.maxHeight * 0.28,
                    minHeight: constraints.maxHeight * 0.28,
                    panelBuilder: (sc) => _panel(sc,
                        checkoutVM.details!.cartInfo!, checkoutVM, constraints),
                    onPanelSlide: (double pos) {},
                  )
                ],
              );
            }),
      );
    });
  }

  Widget _panel(ScrollController controller, CartDetailInfoModel info,
      CheckoutVM checkoutVM, BoxConstraints constraints) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: constraints.maxHeight * 0.2,
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
                ApplyCoupon(
                  onApplyCouponTextTap: () => onApplyCouponTextTap(checkoutVM),
                  disableSlidingUI: disableSlidingUI,
                  checkoutVM: checkoutVM,
                  constraints: boxConstraints,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: AppLocalizations.of(context)!.couponOff,
                      fontSize: 12.sp,
                    ),
                    CustomText(
                      text:
                          " ${checkoutVM.details?.cart?.coupon?.toString() ?? 0}"
                                  " " +
                              AppLocalizations.of(context)!.currency,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: AppLocalizations.of(context)!.totalCost,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        text: " ${info.totalPrice?.toString() ?? '?'}" +
                            " " +
                            AppLocalizations.of(context)!.currency,
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
        Expanded(
          child: CustomButton(
            size: Size(double.infinity, constraints.maxHeight * 0.08),
            text: AppLocalizations.of(context)!.pay +
                " ${info.totalPrice?.toString() ?? '?'} " +
                AppLocalizations.of(context)!.currency,
            textFontSize: 14.sp,
            // circularSize: 20,
            onTap: () => _navigationService.router.navigate(
              PlaceOrderScreenRoute(),
            ),
          ),
        ),
      ],
    );
  }

  void onApplyCouponTextTap(CheckoutVM checkoutVM) {
    disableSlidingUI = false;
    checkoutVM.notifyListeners();
  }
}
