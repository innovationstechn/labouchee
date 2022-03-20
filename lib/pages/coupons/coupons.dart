import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:labouchee/pages/coupons/coupons_viewmodel.dart';
import 'package:labouchee/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/locator.dart';
import '../../models/available_coupon.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_circular_progress_indicator.dart';

class Coupons extends StatefulWidget {
  const Coupons({Key? key}) : super(key: key);

  @override
  _CouponsState createState() => _CouponsState();
}

class _CouponsState extends State<Coupons> {
  final _snackbarService = locator<SnackbarService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppLocalizations.of(context)!.coupons),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: ViewModelBuilder<CouponVM>.reactive(
          viewModelBuilder: () => CouponVM(),
          onModelReady: (model) => model.initialize(),
          builder: (context, couponsVM, _) {
            if (couponsVM.isBusy) {
              return const Center(
                child: CustomCircularProgressIndicator(),
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
                      '${coupon.amount ?? 0} ' +
                          AppLocalizations.of(context)!.currency,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.off,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
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
                      fontSize: 10.sp,
                      padding: const EdgeInsets.only(bottom: 10),
                    ),
                    Text(
                      AppLocalizations.of(context)!.status +
                          ': ${coupon.status == '1' ? AppLocalizations.of(context)!.available : AppLocalizations.of(context)!.notAvailable}',
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
            Text(
              AppLocalizations.of(context)!.couponCode,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 4),
            GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(text: coupon.code));
                _snackbarService.showSnackbar(message: "Coupon Copied");
              },
              child: Text(
                coupon.code ?? '-',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: secondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            CustomText(
              text: coupon.description ?? "",
              maxLines: 1,
            ),
            const Spacer(),
            Text(
              AppLocalizations.of(context)!.validTill +
                  ' - ${coupon.validTill ?? "-"}',
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
