import 'package:labouchee/models/available_coupon.dart';
import 'package:labouchee/models/category.dart';
import 'package:labouchee/models/product.dart';
import 'package:labouchee/models/product_filter.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/locator.dart';
import '../../services/api/labouchee_api.dart';

class CategoryProductListingVM extends BaseViewModel {
  final _snackbarService = locator<SnackbarService>();
  final _api = locator<LaboucheeAPI>();
  CategoryModel _categoryModel;

  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;

  CategoryProductListingVM({required CategoryModel categoryModel})
      : _categoryModel = categoryModel;

  Future<void> initialize() async {
    Future<void> _initialize() async {
      try {
        _products = await _api.fetchProducts(
          ProductFilterModel(categoryId: _categoryModel.id!),
        );
      } catch (e) {
        _snackbarService.showSnackbar(message: e.toString());
      }
    }

    await runBusyFuture(_initialize());
  }
}
