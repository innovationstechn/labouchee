import 'package:labouchee/app/routes.gr.dart';
import 'package:labouchee/models/my_order.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/locator.dart';
import '../../services/api/labouchee_api.dart';
import '../../services/navigator.dart';

class MyOrdersVM extends BaseViewModel {
  final _snackbarService = locator<SnackbarService>();
  final _navigationService = locator<NavigatorService>();
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

  void navigateToOrderDetailPage(MyOrderModel myOrderModel) {
    _navigationService.router
        .navigate(MyOrdersDetailScreenRoute(order: myOrderModel));
  }
}
