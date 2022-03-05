import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:labouchee/app/locator.dart';
import 'package:labouchee/constants/general.dart';
import 'package:labouchee/models/apply_coupon.dart';
import 'package:labouchee/models/available_coupon.dart';
import 'package:labouchee/models/banner.dart';
import 'package:labouchee/models/banner_filter.dart';
import 'package:labouchee/models/branch.dart';
import 'package:labouchee/models/cart.dart';
import 'package:labouchee/models/cart_detail.dart';
import 'package:labouchee/models/cart_update.dart';
import 'package:labouchee/models/category.dart';
import 'package:labouchee/models/coupon.dart';
import 'package:labouchee/models/inquiry.dart';
import 'package:labouchee/models/login_model.dart';
import 'package:labouchee/models/mark_read_notification.dart';
import 'package:labouchee/models/my_order.dart';
import 'package:labouchee/models/my_order_detail.dart';
import 'package:labouchee/models/notification.dart';
import 'package:labouchee/models/notification_filter.dart';
import 'package:labouchee/models/place_order.dart';
import 'package:labouchee/models/place_order_error.dart';
import 'package:labouchee/models/product.dart';
import 'package:labouchee/models/product_detail.dart';
import 'package:labouchee/models/product_filter.dart';
import 'package:labouchee/models/product_review.dart';
import 'package:labouchee/models/register_model.dart';
import 'package:labouchee/models/register_error_model.dart';
import 'package:labouchee/models/reset_password_error_model.dart';
import 'package:labouchee/models/shipping_location.dart';
import 'package:labouchee/models/submit_review.dart';
import 'package:labouchee/models/update_profile.dart';
import 'package:labouchee/models/update_profile_error.dart';
import 'package:labouchee/models/user.dart';
import 'package:labouchee/services/api/api.dart';
import 'package:labouchee/services/api/exceptions/api_exceptions.dart';
import 'package:labouchee/services/language_service.dart';
import 'package:labouchee/services/local_storage/hive_local_storage.dart';
import 'package:labouchee/services/local_storage/local_storage.dart';

import '../../models/reset_password_model.dart';

class LaboucheeAPI implements API {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: API_ADDRESS,
      connectTimeout: API_TIMEOUT.inMilliseconds,
    ),
  );

  final LocalStorage _localStorage = locator<HiveLocalStorage>();

  LaboucheeAPI() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _localStorage.token();
          final language =
              (await _localStorage.locale()) ?? DEFAULT_LOCALE.languageCode;

          options.headers['api_key'] = API_KEY;
          options.headers['Accept'] = 'application/json';
          options.headers['language'] = language;

          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          handler.next(options);
        },
      ),
    );
  }

  @override
  Future<String> login(LoginModel loginModel) async {
    try {
      final response = await _dio.post(
        '/login',
        data: loginModel,
      );

      return response.data['token'];
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 401) {
          throw UnauthorisedException(
            e.response!.data['message'] ??
                "There was a problem while logging in.",
          );
        } else {
          throw RequestFailureException(
            e.response!.data['message'] ??
                "Oops! We could not serve your request.",
          );
        }
      } else {
        throw RequestFailureException(
          "No internet detected. Please check your internet connection and try again.",
        );
      }
    } catch (e) {
      log(e.toString());
      throw 'Sorry, we encountered an unknown error';
    }
  }

  @override
  Future<String> register(RegisterModel registerModel) async {
    try {
      final response = await _dio.post(
        '/register',
        data: FormData.fromMap(
          registerModel.toJson(),
        ),
      );

      return response.data['token'];
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 422) {
          throw ErrorModelException<RegisterValidationErrorModel>(
            e.response!.data['message'],
            RegisterValidationErrorModel.fromJson(
              e.response!.data['errors'],
            ),
          );
        } else {
          throw RequestFailureException(
            e.response!.data['message'] ??
                "Oops! We could not serve your request.",
          );
        }
      } else {
        throw RequestFailureException(
          "Oops! We could not serve your request.",
        );
      }
    } catch (e) {
      log(e.toString());
      throw 'Sorry, we encountered an unknown error';
    }
  }

  @override
  Future<String> forgotPassword(String email) async {
    try {
      final response = await _dio.post(
        '/forgot-password',
        data: {
          'email': email,
        },
      );

      return response.data['code'];
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 422) {
          throw NoEmailFoundException(
            e.response!.data['message'],
          );
        } else {
          throw RequestFailureException(
            e.response!.data['message'] ??
                "Oops! We could not serve your request.",
          );
        }
      } else {
        throw RequestFailureException(
          "Oops! We could not serve your request.",
        );
      }
    } catch (e) {
      log(e.toString());
      throw 'Sorry, we encountered an unknown error';
    }
  }

  @override
  Future<void> resetPassword(ResetPasswordModel model) async {
    try {
      final response = await _dio.post(
        '/reset-password',
        data: model.toJson(),
      );
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 422) {
          throw ErrorModelException<ResetPasswordErrorModel>(
            e.response!.data['message'],
            ResetPasswordErrorModel.fromJson(
              e.response!.data['error'],
            ),
          );
        } else {
          throw RequestFailureException(
            e.response!.data['message'] ??
                "Oops! We could not serve your request.",
          );
        }
      } else {
        throw RequestFailureException(
          "No internet detected. Please check your internet connection and try again.",
        );
      }
    } catch (e) {
      log(e.toString());
      throw 'Sorry, we encountered an unknown error';
    }
  }

  @override
  Future<String> sendOTP() async {
    try {
      final response = await _dio.post('/send-verification-code');

      return response.data['verification_code'].toString();
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 400) {
          throw ErrorModelException<int>(
            e.response!.data['message'],
            e.response!.data['verification_code'],
          );
        } else {
          throw RequestFailureException(
            e.response!.data['message'] ??
                "Oops! We could not serve your request.",
          );
        }
      } else {
        throw RequestFailureException(
          "No internet detected. Please check your internet connection and try again.",
        );
      }
    } catch (e) {
      log(e.toString());
      throw 'Sorry, we encountered an unknown error';
    }
  }

  @override
  Future<void> verifyUser() async {
    try {
      final response = await _dio.post('/verify-number');

      return response.data['code'];
    } on DioError catch (e) {
      if (e.response != null && e.response!.statusCode != 200) {
        throw RequestFailureException(
          e.response!.data['message'] ??
              "Oops! We could not serve your request.",
        );
      } else {
        throw RequestFailureException(
          "No internet detected. Please check your internet connection and try again.",
        );
      }
    } catch (e) {
      log(e.toString());
      throw 'Sorry, we encountered an unknown error';
    }
  }

  @override
  Future<UserModel> getUser() async {
    try {
      final response = await _dio.get('/auth-user');

      return UserModel.fromJson(response.data['data']);
    } on DioError catch (e) {
      if (e.response != null) {
        throw RequestFailureException(
          e.response!.data['message'] ??
              "Oops! We could not serve your request.",
        );
      } else {
        throw RequestFailureException(
          "No internet detected. Please check your internet connection and try again.",
        );
      }
    } catch (e) {
      log(e.toString());
      throw 'Sorry, we encountered an unknown error';
    }
  }

  @override
  Future<List<BannerModel>> fetchBanners(BannerFilterModel filter) async {
    try {
      final response = await _dio.get(
        '/banners',
        queryParameters: filter.toJson(),
      );

      return response.data['data']
          .map((e) => BannerModel.fromJson(e))
          .toList()
          .cast<BannerModel>();
    } on DioError catch (e) {
      if (e.response != null) {
        throw RequestFailureException(
          e.response!.data['message'] ??
              "Oops! We could not serve your request.",
        );
      } else {
        throw RequestFailureException(
          "No internet detected. Please check your internet connection and try again.",
        );
      }
    } catch (e) {
      log(e.toString());
      throw 'Sorry, we encountered an unknown error';
    }
  }

  @override
  Future<List<ProductModel>> fetchProducts(ProductFilterModel filter) async {
    try {
      final response = await _dio.get(
        '/products',
        queryParameters: filter.toJson(),
      );

      return response.data['data']
          .map((e) => ProductModel.fromJson(e))
          .toList()
          .cast<ProductModel>();
    } on DioError catch (e) {
      if (e.response != null) {
        throw RequestFailureException(
          e.response!.data['message'] ??
              "Oops! We could not serve your request.",
        );
      } else {
        throw RequestFailureException(
          "No internet detected. Please check your internet connection and try again.",
        );
      }
    } catch (e) {
      log(e.toString());
      throw 'Sorry, we encountered an unknown error';
    }
  }

  @override
  Future<ProductDetailModel> fetchProductDetail(int id) async {
    try {
      final response = await _dio.get(
        '/products/$id/details',
      );

      return ProductDetailModel.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response?.statusCode == 404) {
          throw RequestFailureException(
              'Sorry, we could not get that product. Please contact administrator.');
        } else {
          throw RequestFailureException(
            e.response!.data['message'] ??
                "Oops! We could not serve your request.",
          );
        }
      } else {
        throw RequestFailureException(
          "No internet detected. Please check your internet connection and try again.",
        );
      }
    } catch (e) {
      log(e.toString());
      throw 'Sorry, we encountered an unknown error';
    }
  }

  @override
  Future<List<ProductReviewModel>> fetchProductReviews(int productId) async {
    try {
      final response = await _dio.get(
        '/$productId/reviews',
      );

      return response.data['data']
          .map((e) => ProductReviewModel.fromJson(e))
          .toList()
          .cast<ProductReviewModel>();
    } on DioError catch (e) {
      if (e.response != null) {
        throw RequestFailureException(
          e.response!.data['message'] ??
              "Oops! We could not serve your request.",
        );
      } else {
        throw RequestFailureException(
          "No internet detected. Please check your internet connection and try again.",
        );
      }
    } catch (e) {
      log(e.toString());
      throw 'Sorry, we encountered an unknown error';
    }
  }

  @override
  Future<CartModel> getCart() async {
    try {
      final response = await _dio.get(
        '/get-cart',
      );

      return CartModel.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        throw RequestFailureException(
          e.response!.data['message'] ??
              "Oops! We could not serve your request.",
        );
      } else {
        throw RequestFailureException(
          "No internet detected. Please check your internet connection and try again.",
        );
      }
    } catch (e) {
      log(e.toString());
      throw 'Sorry, we encountered an unknown error';
    }
  }

  @override
  Future<CartDetailModel> getDetailedCart() async {
    try {
      final response = await _dio.get(
        '/cart-info',
      );

      return CartDetailModel.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        throw RequestFailureException(
          e.response!.data['message'] ??
              "Oops! We could not serve your request.",
        );
      } else {
        throw RequestFailureException(
          "No internet detected. Please check your internet connection and try again.",
        );
      }
    } catch (e) {
      log(e.toString());
      throw 'Sorry, we encountered an unknown error';
    }
  }

  @override
  Future<String> updateCart(CartUpdateModel itemDetails) async {
    try {
      final response = await _dio.post(
        '/update-cart-item',
        data: itemDetails.toJson(),
      );

      return response.data['message'] ?? '';
    } on DioError catch (e) {
      if (e.response != null) {
        throw RequestFailureException(
          e.response!.data['message'] ??
              "Oops! We could not serve your request.",
        );
      } else {
        throw RequestFailureException(
          "No internet detected. Please check your internet connection and try again.",
        );
      }
    } catch (e) {
      log(e.toString());
      throw 'Sorry, we encountered an unknown error';
    }
  }

  @override
  Future<List<BranchModel>> getBranches() async {
    try {
      final response = await _dio.get(
        '/branches',
      );

      return response.data['data']
          .map((e) => BranchModel.fromJson(e))
          .toList()
          .cast<BranchModel>();
    } on DioError catch (e) {
      if (e.response != null) {
        throw RequestFailureException(
          e.response!.data['message'] ??
              "Oops! We could not serve your request.",
        );
      } else {
        throw RequestFailureException(
          "No internet detected. Please check your internet connection and try again.",
        );
      }
    } catch (e) {
      log(e.toString());
      throw 'Sorry, we encountered an unknown error';
    }
  }

  @override
  Future<String> placeOrder(PlaceOrderModel order) async {
    try {
      final response = await _dio.post(
        '/place-order',
        data: order.toJson(),
      );

      return response.data['message'] ?? '';
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response?.statusCode == 422) {
          throw ErrorModelException(
            e.response!.data['message'],
            PlaceOrderErrorModel.fromJson(e.response!.data['error']),
          );
        } else {
          throw RequestFailureException(
            e.response!.data['message'] ??
                "Oops! We could not serve your request.",
          );
        }
      } else {
        throw RequestFailureException(
          "No internet detected. Please check your internet connection and try again.",
        );
      }
    } catch (e) {
      log(e.toString());
      throw 'Sorry, we encountered an unknown error';
    }
  }

  @override
  Future<List<AvailableCouponModel>> getAvailableCoupons() async {
    try {
      final response = await _dio.get(
        '/coupons',
      );

      return response.data['coupons']
          .map((e) => AvailableCouponModel.fromJson(e))
          .toList()
          .cast<AvailableCouponModel>();
    } on DioError catch (e) {
      if (e.response != null) {
        throw RequestFailureException(
          e.response!.data['message'] ??
              "Oops! We could not serve your request.",
        );
      } else {
        throw RequestFailureException(
          "No internet detected. Please check your internet connection and try again.",
        );
      }
    } catch (e) {
      log(e.toString());
      throw 'Sorry, we encountered an unknown error';
    }
  }

  @override
  Future<List<ShippingLocationModel>> getShippingLocations() async {
    try {
      final response = await _dio.get(
        '/shipping-locations',
      );

      return response.data['data']
          .map((e) => ShippingLocationModel.fromJson(e))
          .toList()
          .cast<ShippingLocationModel>();
    } on DioError catch (e) {
      if (e.response != null) {
        throw RequestFailureException(
          e.response!.data['message'] ??
              "Oops! We could not serve your request.",
        );
      } else {
        throw RequestFailureException(
          "No internet detected. Please check your internet connection and try again.",
        );
      }
    } catch (e) {
      log(e.toString());
      throw 'Sorry, we encountered an unknown error';
    }
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await _dio.get(
        '/categories',
      );

      return response.data['data']
          .map((e) => CategoryModel.fromJson(e))
          .toList()
          .cast<CategoryModel>();
    } on DioError catch (e) {
      if (e.response != null) {
        throw RequestFailureException(
          e.response!.data['message'] ??
              "Oops! We could not serve your request.",
        );
      } else {
        throw RequestFailureException(
          "No internet detected. Please check your internet connection and try again.",
        );
      }
    } catch (e) {
      log(e.toString());
      throw 'Sorry, we encountered an unknown error';
    }
  }

  @override
  Future<String> postProductReview(SubmitReviewModel review) async {
    try {
      final response = await _dio.post(
        '/post-review',
        data: review.toJson(),
      );

      return response.data['message'] ?? '';
    } on DioError catch (e) {
      if (e.response != null) {
        throw RequestFailureException(
          e.response!.data['message'] ??
              "Oops! We could not serve your request.",
        );
      } else {
        throw RequestFailureException(
          "No internet detected. Please check your internet connection and try again.",
        );
      }
    } catch (e) {
      log(e.toString());
      throw 'Sorry, we encountered an unknown error';
    }
  }

  @override
  Future<List<NotificationModel>> getNotifications(
      NotificationFilterModel filter) async {
    try {
      final response = await _dio.get(
        '/get-notification',
        queryParameters: filter.toJson(),
      );

      return response.data['data']
          .map((e) => NotificationModel.fromJson(e))
          .toList()
          .cast<NotificationModel>();
    } on DioError catch (e) {
      if (e.response != null) {
        throw RequestFailureException(
          e.response!.data['message'] ??
              "Oops! We could not serve your request.",
        );
      } else {
        throw RequestFailureException(
          "No internet detected. Please check your internet connection and try again.",
        );
      }
    } catch (e) {
      log(e.toString());
      throw 'Sorry, we encountered an unknown error';
    }
  }

  @override
  Future<String> markNotificationAsRead(
      MarkReadNotificationModel notifications) async {
    try {
      final response = await _dio.post(
        '/mark-as-read',
        data: notifications.toJson(),
      );

      return response.data['message'] ?? '';
    } on DioError catch (e) {
      if (e.response != null) {
        throw RequestFailureException(
          e.response!.data['message'] ??
              "Oops! We could not serve your request.",
        );
      } else {
        throw RequestFailureException(
          "No internet detected. Please check your internet connection and try again.",
        );
      }
    } catch (e) {
      log(e.toString());
      throw 'Sorry, we encountered an unknown error';
    }
  }

  @override
  Future<bool> applyCoupon(ApplyCouponModel couponModel) async {
    try {
      final response = await _dio.post(
        '/apply-coupon',
        data: couponModel.toJson(),
      );

      return response.data['available'] ?? false;
    } on DioError catch (e) {
      if (e.response != null) {
        throw RequestFailureException(
          e.response!.data['message'] ??
              "Oops! We could not serve your request.",
        );
      } else {
        throw RequestFailureException(
          "No internet detected. Please check your internet connection and try again.",
        );
      }
    } catch (e) {
      log(e.toString());
      throw 'Sorry, we encountered an unknown error';
    }
  }

  @override
  Future<String> submitInquiry(InquiryModel inquiry) async {
    try {
      final response = await _dio.post(
        '/submit-feedback',
        data: inquiry.toJson(),
      );

      return response.data['message'] ?? "";
    } on DioError catch (e) {
      if (e.response != null) {
        throw RequestFailureException(
          e.response!.data['message'] ??
              "Oops! We could not serve your request.",
        );
      } else {
        throw RequestFailureException(
          "No internet detected. Please check your internet connection and try again.",
        );
      }
    } catch (e) {
      log(e.toString());
      throw 'Sorry, we encountered an unknown error';
    }
  }

  @override
  Future<List<MyOrderModel>> myOrders() async {
    try {
      final response = await _dio.get(
        '/get-notification',
      );

      return response.data
          .map((e) => MyOrderModel.fromJson(e))
          .toList()
          .cast<MyOrderModel>();
    } on DioError catch (e) {
      if (e.response != null) {
        throw RequestFailureException(
          e.response!.data['message'] ??
              "Oops! We could not serve your request.",
        );
      } else {
        throw RequestFailureException(
          "No internet detected. Please check your internet connection and try again.",
        );
      }
    } catch (e) {
      log(e.toString());
      throw 'Sorry, we encountered an unknown error';
    }
  }

  @override
  Future<String> updateProfile(UpdateProfileModel update) async {
    try {
      final response = await _dio.post(
        '/update-profile',
        data: update.toJson(),
      );

      return response.data['message'] ?? "";
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response?.statusCode == 422) {
          throw ErrorModelException<UpdateProfileErrorModel>(
            e.response?.data['message'],
            UpdateProfileErrorModel.fromJson(
              e.response?.data['errors'],
            ),
          );
        } else {
          throw RequestFailureException(
            e.response!.data['message'] ??
                "Oops! We could not serve your request.",
          );
        }
      } else {
        throw RequestFailureException(
          "No internet detected. Please check your internet connection and try again.",
        );
      }
    } catch (e) {
      log(e.toString());
      throw 'Sorry, we encountered an unknown error';
    }
  }

  @override
  Future<MyOrderDetailModel> getOrderDetail(int id) async {
    try {
      final response = await _dio.get(
        '/my-order/$id',
      );

      return MyOrderDetailModel.fromJson(response.data['data']);
    } on DioError catch (e) {
      if (e.response != null) {
        throw RequestFailureException(
          e.response!.data['message'] ??
              "Oops! We could not serve your request.",
        );
      } else {
        throw RequestFailureException(
          "No internet detected. Please check your internet connection and try again.",
        );
      }
    } catch (e) {
      log(e.toString());
      throw 'Sorry, we encountered an unknown error';
    }
  }
}
