import 'package:labouchee/models/product.dart';
import 'package:labouchee/models/product_detail.dart';
import 'package:labouchee/models/product_filter.dart';
import 'package:labouchee/models/product_review.dart';
import 'package:labouchee/models/submit_review.dart';
import 'package:labouchee/utils/product_size.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/locator.dart';
import '../../services/api/labouchee_api.dart';
import '../../services/cart_service.dart';

class ProductDetailsVM extends BaseViewModel {
  final _laboucheeAPI = locator<LaboucheeAPI>();
  final _snackbarService = locator<SnackbarService>();
  final _cartService = locator<CartService>();
  ProductDetailModel _productDetailModel;

  ProductDetailModel get details => _productDetailModel;

  List<ProductReviewModel> _productReviews = [];

  List<ProductReviewModel> get productReviews => _productReviews;

  ProductDetailsVM({required ProductModel product})
      : _productDetailModel = ProductDetailModel.fromProductModel(product);

  Future<void> loadDetails() async {
    Future<void> _loadDetails() async {
      try {
        _productDetailModel = await _laboucheeAPI.fetchProductDetail(
          _productDetailModel.id!,
        );
        _productReviews = await _laboucheeAPI.fetchProductReviews(
          _productDetailModel.id!,
        );
      } catch (e) {
        _snackbarService.showSnackbar(message: e.toString());
      }
    }

    await runBusyFuture(_loadDetails());
  }

  Future<void> addToCart(int quantity, String? size) async {
    Future<void> _addToCart() async {
      try {
        final message = await _cartService.addItem(
          _productDetailModel.id!,
          quantity,
          sizeInEnum: productFromString(size!.toLowerCase()),
        );

        _snackbarService.showSnackbar(message: message);
      } catch (e) {
        _snackbarService.showSnackbar(message: e.toString());
      }
    }

    await runBusyFuture(_addToCart());
  }

  Future<void> postProductReview(String review, int rating) async {
    Future<void> _postProductReview() async {
      try {
        final submitReview = SubmitReviewModel(
          productId: _productDetailModel.id,
          review: review,
          rating: rating,
        );

        await _laboucheeAPI.postProductReview(submitReview);
      } catch (e) {
        _snackbarService.showSnackbar(message: e.toString());
      }
    }

    await runBusyFuture(_postProductReview());
  }
}
