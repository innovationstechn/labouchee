import 'package:labouchee/app/routes.gr.dart';
import 'package:labouchee/models/banner.dart';
import 'package:labouchee/models/banner_filter.dart';
import 'package:labouchee/models/product.dart';
import 'package:labouchee/models/product_filter.dart';
import 'package:labouchee/models/user.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/locator.dart';
import '../../services/api/labouchee_api.dart';

class LandingVM extends BaseViewModel {
  final _laboucheeAPI = locator<LaboucheeAPI>();
  final _snackbarService = locator<SnackbarService>();
  final _navigationService = locator<NavigationService>();

  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;

  List<BannerModel> _banners = [];

  List<BannerModel> get banners => _banners;

  List<ProductModel> _featured = [];

  List<ProductModel> get featured => _featured;

  List<ProductModel> _hotSale = [];

  List<ProductModel> get hotSale => _hotSale;

  List<ProductModel> _mostViewed = [];

  List<ProductModel> get mostViewed => _mostViewed;

  Future<void> initialize() async {
    Future<void> _initialize() async {
      try {
        UserModel user = await _laboucheeAPI.getUser();

        if (user.numberVerifiedAt == null) {
          _navigationService.clearStackAndShow(Routes.otpScreenRoute);
        }

        final data = await Future.wait([
          _laboucheeAPI.fetchProducts(ProductFilterModel()),
          _laboucheeAPI.fetchBanners(BannerFilterModel(type: 'main')),
          _laboucheeAPI.fetchProducts(ProductFilterModel(featured: true)),
          _laboucheeAPI.fetchProducts(ProductFilterModel(hotSale: true)),
          _laboucheeAPI.fetchProducts(ProductFilterModel(mostViewed: true))
        ]);

        _products = data[0] as List<ProductModel>;
        _banners = data[1] as List<BannerModel>;
        _featured = data[2] as List<ProductModel>;
        _hotSale = data[3] as List<ProductModel>;
        _mostViewed = data[4] as List<ProductModel>;
      } catch (e) {
        setError(e.toString());
        _snackbarService.showSnackbar(
          message: e.toString(),
        );
      }
    }

    await runBusyFuture(
      _initialize(),
    );
  }
}
