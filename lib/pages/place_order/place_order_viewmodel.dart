import 'package:labouchee/models/branch.dart';
import 'package:labouchee/models/order.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/locator.dart';
import '../../models/place_order.dart';
import '../../services/api/labouchee_api.dart';

class PlaceOrderVM extends BaseViewModel {
  final _snackbarService = locator<SnackbarService>();
  final _api = locator<LaboucheeAPI>();

  List<BranchModel> _branches = [];

  List<BranchModel> get branches => _branches;

  Future<void> initialize() async {
    Future<void> _initialize() async {
      try {
        _branches = await _api.getBranches();
      } catch (e) {
        _snackbarService.showSnackbar(message: e.toString());
      }
    }

    await runBusyFuture(_initialize());
  }

  Future<void> placeOrder(
      String name,
      String phone,
      String city,
      String email,
      PaymentMethod paymentMethod,
      String branch,
      String addr1,
      String? addr2) async {
    final PlaceOrderModel order = PlaceOrderModel(
      name: name,
      phone: phone,
      city: city,
      email: email,
      paymentMethod: paymentMethod,
      branch: branch,
      addr1: addr1,
      addr2: addr2,
    );

    switch (paymentMethod) {
      case PaymentMethod.cashOnDelivery:
      case PaymentMethod.pickup:
      case PaymentMethod.mada:
        {
          final message = await _api.placeOrder(order);
          _snackbarService.showSnackbar(message: message);
          return;
        }
      case PaymentMethod.digital:
        {
          final paymentSuccessful = await payUsingDigital(order);

          if (paymentSuccessful) {
            final message = await _api.placeOrder(order);
            _snackbarService.showSnackbar(message: message);
          } else {
            _snackbarService.showSnackbar(
              message:
                  'Could not place order. Please contact customer support.',
            );
          }
        }
    }
  }

  Future<bool> payUsingDigital(PlaceOrderModel order) async {
    return await Future.delayed(Duration.zero, () => true);
  }
}
