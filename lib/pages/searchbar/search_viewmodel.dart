import 'package:labouchee/models/product.dart';
import 'package:labouchee/models/product_filter.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/locator.dart';
import '../../services/api/labouchee_api.dart';

class SearchVM extends BaseViewModel {
  final _laboucheeAPI = locator<LaboucheeAPI>();
  final _snackbarService = locator<SnackbarService>();

  List<ProductModel> _searched = [];

  List<ProductModel> get searched => _searched;

  Future<void> search(String query) async {
    Future<void> _search() async {
      try {
        _searched = await _laboucheeAPI.fetchProducts(
          ProductFilterModel(query: query),
        );
      } catch (e) {
        _snackbarService.showSnackbar(message: e.toString());
      }
    }

    await runBusyFuture(_search());
  }
}
