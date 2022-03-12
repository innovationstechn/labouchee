import 'package:flutter/cupertino.dart';
import 'package:labouchee/models/cart_detail.dart';
import 'package:labouchee/services/api/labouchee_api.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/locator.dart';
import '../../models/apply_coupon.dart';
import '../../services/cart_service.dart';
import '../../services/navigator.dart';
import '../../utils/helpers.dart';

class CheckoutVM extends BaseViewModel {
  final _snackbarService = locator<SnackbarService>();
  final _navigationService = locator<NavigatorService>();
  final _api = locator<LaboucheeAPI>();

  CartDetailModel? details;

  Future<void> initialize() async {
    Future<void> _initialize() async {
      try {
        details = await _api.getDetailedCart();
      } catch (e) {
        _snackbarService.showSnackbar(message: e.toString());
      }
    }

    await runBusyFuture(_initialize());
  }

  Future<void> applyCoupon(String coupon) async {
    Future<void> _applyCoupon() async {
      try {
        final message = await _api.applyCoupon(
          ApplyCouponModel(
            coupon: coupon,
            mobileId: await uniqueDeviceIdentifier(),
          ),
        );

        _snackbarService.showSnackbar(message: message);
      } catch (e) {
        _snackbarService.showSnackbar(message: e.toString());
      }
    }

    await runBusyFuture(_applyCoupon());
  }
}
