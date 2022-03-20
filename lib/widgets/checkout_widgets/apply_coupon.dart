import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labouchee/pages/checkout/checkout_viewmodel.dart';
import 'package:labouchee/widgets/custom_button.dart';
import 'package:sizer/sizer.dart';
import '../../widgets/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ApplyCoupon extends StatelessWidget {
  final CheckoutVM checkoutVM;
  final bool disableSlidingUI;
  final BoxConstraints constraints;
  final Function onApplyCouponTextTap;
  final TextEditingController couponTextController = TextEditingController();

  ApplyCoupon({
    Key? key,
    required this.checkoutVM,
    required this.disableSlidingUI,
    required this.constraints,
    required this.onApplyCouponTextTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (disableSlidingUI &&
        (checkoutVM.details?.cartInfo?.discountAmount ?? -1) <= 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: AppLocalizations.of(context)!.haveCouponCode,
            fontSize: 12.sp,
            fontWeight: FontWeight.normal,
          ),
          CustomText(
              text: AppLocalizations.of(context)!.applyCoupon,
              color: Theme.of(context).primaryColor,
              fontSize: 10.sp,
              fontWeight: FontWeight.normal,
              onTap: () => onApplyCouponTextTap(),
          )],
      );
    }
    if (!disableSlidingUI &&
        (checkoutVM.details?.cartInfo?.discountAmount ?? -1) <= 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: constraints.maxWidth * 0.74 - 8,
            // height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Theme.of(context).primaryColor)),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: TextFormField(
                  controller: couponTextController,
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 14.sp, letterSpacing: 1.0, height: 1.5),
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration.collapsed(
                    hintText: AppLocalizations.of(context)!.haveCouponCode,
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
            text: AppLocalizations.of(context)!.apply,
            textColor: Colors.white,
            buttonColor: Theme.of(context).primaryColor,
            textFontSize: 12.sp,
            size: Size(constraints.maxWidth * 0.23,
                constraints.maxHeight * 0.06),
            onTap: () => checkoutVM.applyCoupon(couponTextController.text)
          ),
        ],
      );
    }
    return Container();
  }
}
