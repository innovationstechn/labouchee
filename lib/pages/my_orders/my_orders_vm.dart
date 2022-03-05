import 'package:labouchee/models/my_order.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/locator.dart';
import '../../services/api/labouchee_api.dart';

class MyOrdersVM extends BaseViewModel {
  final _snackbarService = locator<SnackbarService>();
  final _api = locator<LaboucheeAPI>();

  List<MyOrderModel> _orders = [];
  List<MyOrderModel> get orders => _orders;

  Future<void> loadData() async {
    Future<void> _loadData() async {
      try {
        _orders = await _api.myOrders();
      } catch (e) {
        _snackbarService.showSnackbar(message: e.toString());
      }
    }

    await runBusyFuture(_loadData());
  }
}