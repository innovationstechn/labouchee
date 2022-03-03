import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:labouchee/pages/coupons/coupons_viewmodel.dart';
import 'package:labouchee/widgets/custom_text.dart';
import 'package:stacked/stacked.dart';

import '../../models/available_coupon.dart';
import '../../widgets/custom_app_bar.dart';

class Coupons extends StatefulWidget {
  const Coupons({Key? key}) : super(key: key);

  @override
  _CouponsState createState() => _CouponsState();
}

class _CouponsState extends State<Coupons> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Coupons'),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: ViewModelBuilder<CouponVM>.reactive(
          viewModelBuilder: () => CouponVM(),
          onModelReady: (model) => model.initialize(),
          builder: (context, couponsVM, _) {
            if (couponsVM.isBusy) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
              itemCount: couponsVM.coupons.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: customCouponCard(couponsVM.coupons[index]),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget customCouponCard(AvailableCouponModel coupon) {
    const Color primaryColor = Colors.white;
    Color secondaryColor = Theme.of(context).primaryColor;

    return CouponCard(
      height: 150,
      backgroundColor: primaryColor,
      curveAxis: Axis.vertical,
      firstChild: Container(
        decoration: BoxDecoration(
          color: secondaryColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${coupon.amount ?? 0} RAYAL',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'OFF',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(color: Colors.white54, height: 0),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: coupon.title ?? "",
                      color: Colors.white,
                      padding: const EdgeInsets.only(bottom: 10),
                    ),
                    Text(
                      'Status: ${coupon.status == '1' ? 'Available' : 'Not Available'}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      secondChild: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Coupon Code',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              coupon.code ?? '-',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                color: secondaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            const CustomText(
              text: 'Description',
            ),
            const Spacer(),
            Text(
              'Valid Till - ${coupon.validTill ?? "-"}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
