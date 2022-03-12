import 'package:labouchee/models/available_coupon.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/locator.dart';
import '../../services/api/labouchee_api.dart';

class CouponVM extends BaseViewModel {
  final _snackbarService = locator<SnackbarService>();
  final _api = locator<LaboucheeAPI>();

  List<AvailableCouponModel> _coupons = [];
  List<AvailableCouponModel> get coupons => _coupons;

  Future<void> initialize() async {
    Future<void> _initialize() async {
      try {
        _coupons = await _api.getAvailableCoupons();
      } catch (e) {
        _snackbarService.showSnackbar(message: e.toString());
      }
    }

    await runBusyFuture(_initialize());
  }
}
