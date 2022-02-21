import 'package:labouchee/models/product.dart';
import 'package:labouchee/models/product_detail.dart';
import 'package:labouchee/models/product_filter.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/locator.dart';
import '../../services/api/labouchee_api.dart';

class ProductDetailsVM extends BaseViewModel {
  final _laboucheeAPI = locator<LaboucheeAPI>();
  final _snackbarService = locator<SnackbarService>();
  ProductDetailModel _productDetailModel;

  ProductDetailModel get details => _productDetailModel;

  ProductDetailsVM({required ProductModel product})
      : _productDetailModel = ProductDetailModel.fromProductModel(product);

  Future<void> loadDetails() async {
    Future<void> _loadDetails() async {
      try {
        _productDetailModel = await _laboucheeAPI.fetchProductDetail(
          _productDetailModel.id!,
        );
      } catch (e) {
        _snackbarService.showSnackbar(message: e.toString());
      }
    }

    await runBusyFuture(_loadDetails());
  }
}
