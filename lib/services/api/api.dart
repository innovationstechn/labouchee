import 'package:labouchee/models/apply_coupon.dart';
import 'package:labouchee/models/available_coupon.dart';
import 'package:labouchee/models/banner.dart';
import 'package:labouchee/models/banner_filter.dart';
import 'package:labouchee/models/branch.dart';
import 'package:labouchee/models/cart.dart';
import 'package:labouchee/models/cart_detail.dart';
import 'package:labouchee/models/cart_update.dart';
import 'package:labouchee/models/category.dart';
import 'package:labouchee/models/inquiry.dart';
import 'package:labouchee/models/mark_read_notification.dart';
import 'package:labouchee/models/notification.dart';
import 'package:labouchee/models/notification_filter.dart';
import 'package:labouchee/models/place_order.dart';
import 'package:labouchee/models/product.dart';
import 'package:labouchee/models/product_detail.dart';
import 'package:labouchee/models/product_filter.dart';
import 'package:labouchee/models/product_review.dart';
import 'package:labouchee/models/reset_password_model.dart';
import 'package:labouchee/models/shipping_location.dart';
import 'package:labouchee/models/update_profile.dart';
import 'package:labouchee/models/user.dart';

import '../../models/login_model.dart';
import '../../models/my_order.dart';
import '../../models/register_model.dart';
import '../../models/submit_review.dart';

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

  Future<CartModel> getCart();

  Future<String> updateCart(CartUpdateModel details);

  Future<CartDetailModel> getDetailedCart();

  Future<List<BranchModel>> getBranches();

  Future<String> placeOrder(PlaceOrderModel order);

  Future<List<AvailableCouponModel>> getAvailableCoupons();

  Future<List<ShippingLocationModel>> getShippingLocations();

  Future<List<CategoryModel>> getCategories();

  Future<String> postProductReview(SubmitReviewModel review);

  Future<List<NotificationModel>> getNotifications(
      NotificationFilterModel filter);

  Future<String> markNotificationAsRead(
      MarkReadNotificationModel notifications);

  Future<bool> applyCoupon(ApplyCouponModel couponModel);

  Future<String> submitInquiry(InquiryModel inquiry);

  Future<String> updateProfile(UpdateProfileModel update);

  Future<List<MyOrderModel>> myOrders();
}
