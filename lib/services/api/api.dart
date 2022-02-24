import 'package:labouchee/models/banner.dart';
import 'package:labouchee/models/banner_filter.dart';
import 'package:labouchee/models/product.dart';
import 'package:labouchee/models/product_detail.dart';
import 'package:labouchee/models/product_filter.dart';
import 'package:labouchee/models/product_review.dart';
import 'package:labouchee/models/reset_password_model.dart';
import 'package:labouchee/models/user.dart';

import '../../models/login_model.dart';
import '../../models/register_model.dart';

abstract class API {
  Future<String> register(RegisterModel registerModel);
  Future<String> login(LoginModel loginModel);
  Future<String> forgotPassword(String email);
  Future<void> resetPassword(ResetPasswordModel model);
  Future<String> sendOTP();
  Future<void> verifyUser();
  Future<UserModel> getUser();
  Future<List<ProductModel>> fetchProducts(ProductFilterModel filter);
  Future<List<BannerModel>> fetchBanners(BannerFilterModel filter);
  Future<ProductDetailModel> fetchProductDetail(int id);
  Future<List<ProductReviewModel>> fetchProductReviews(int productId);
}