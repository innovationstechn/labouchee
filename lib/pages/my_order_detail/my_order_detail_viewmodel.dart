import 'package:labouchee/models/my_order.dart';
import 'package:labouchee/models/my_order_detail.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/locator.dart';
import '../../services/api/labouchee_api.dart';

class MyOrderDetailVM extends BaseViewModel {
  final _snackbarService = locator<SnackbarService>();
  final _api = locator<LaboucheeAPI>();

  final MyOrderModel order;

  MyOrderDetailModel? _detail;
  MyOrderDetailModel? get detail => _detail;

  MyOrderDetailVM({required this.order});

  Future<void> loadData() async {
    Future<void> _loadData() async {
      try {
        _detail = await _api.getOrderDetail(order.id!);
      } catch (e) {
        _snackbarService.showSnackbar(message: e.toString());
      }
    }

    await runBusyFuture(_loadData());
  }
}
