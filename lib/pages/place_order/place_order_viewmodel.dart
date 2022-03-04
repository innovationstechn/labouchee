import 'package:labouchee/models/apply_coupon.dart';
import 'package:labouchee/models/branch.dart';
import 'package:labouchee/models/order.dart';
import 'package:labouchee/models/shipping_location.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/locator.dart';
import '../../models/place_order.dart';
import '../../models/place_order_error.dart';
import '../../services/api/exceptions/api_exceptions.dart';
import '../../services/api/labouchee_api.dart';
import '../../utils/helpers.dart';

class PlaceOrderVM extends BaseViewModel {
  final _snackbarService = locator<SnackbarService>();
  final _api = locator<LaboucheeAPI>();

  List<BranchModel> _branches = [];

  List<BranchModel> get branches => _branches;

  List<ShippingLocationModel> _locations = [];

  List<ShippingLocationModel> get locations => _locations;

  Future<void> initialize() async {
    Future<void> _initialize() async {
      try {
        _branches = await _api.getBranches();
        _locations = await _api.getShippingLocations();
      } catch (e) {
        _snackbarService.showSnackbar(message: e.toString());
      }
    }

    await runBusyFuture(_initialize());
  }

  Future<void> placeOrder(
    String name,
    String phone,
    int? city,
    String email,
    PaymentMethod paymentMethod,
    int? branch,
    String addr1,
    String? addr2,
    String? bookingDate,
    String? bookingTime,
    String? notes,
  ) async {
    final PlaceOrderModel order = PlaceOrderModel(
      name: name,
      phone: phone,
      city: city,
      email: email,
      paymentMethod: paymentMethod,
      branch: branch,
      addr1: addr1,
      addr2: addr2,
      bookingDate: bookingDate,
      bookingTime: bookingTime,
      notes: notes,
    );

    switch (paymentMethod) {
      case PaymentMethod.digital:
        {
          final paymentSuccessful = await payUsingDigital(order);

          if (!paymentSuccessful) {
            _snackbarService.showSnackbar(
              message:
                  'Could not place order. Please contact customer support.',
            );
            return;
          }

          break;
        }
      case PaymentMethod.cashOnDelivery:
      case PaymentMethod.pickup:
      case PaymentMethod.mada:
    }

    try {
      final message = await _api.placeOrder(order);
      _snackbarService.showSnackbar(message: message);
    } catch (e) {
      if (e is ErrorModelException) {
        setError(e.error as PlaceOrderErrorModel);
        _snackbarService.showSnackbar(message: e.message);
      } else {
        _snackbarService.showSnackbar(message: e.toString());
      }
    }
  }

  Future<bool> payUsingDigital(PlaceOrderModel order) async {
    return await Future.delayed(Duration.zero, () => true);
  }

  Future<void> applyCoupon(String coupon) async {
    Future<void> _applyCoupon() async {
      try {
        final available = await _api.applyCoupon(
          ApplyCouponModel(
            coupon: coupon,
            mobileId: await uniqueDeviceIdentifier(),
          ),
        );

        if (available) {
          _snackbarService.showSnackbar(message: 'Successfully applied coupon');
          await initialize();
        } else {
          _snackbarService.showSnackbar(
              message: 'That coupon is not available');
        }
      } catch (e) {
        _snackbarService.showSnackbar(message: e.toString());
      }
    }

    await runBusyFuture(_applyCoupon());
  }
}
