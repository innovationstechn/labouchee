import 'package:auto_route/auto_route.dart';
import 'package:labouchee/pages/branches/branches.dart';
import 'package:labouchee/pages/categories_listing/categories_listing.dart';
import 'package:labouchee/pages/categories_product_listing/categories_product_listing.dart';
import 'package:labouchee/pages/checkout/checkout.dart';
import 'package:labouchee/pages/coupons/coupons.dart';
import 'package:labouchee/pages/customer_support/customer_support.dart';
import 'package:labouchee/pages/forgot/forgot_view.dart';
import 'package:labouchee/pages/landing/home_view.dart';
import 'package:labouchee/pages/language/language.dart';
import 'package:labouchee/pages/login/login_view.dart';
import 'package:labouchee/pages/my_order_detail/my_order_detail.dart';
import 'package:labouchee/pages/my_orders/my_orders.dart';
import 'package:labouchee/pages/onboarding/onboarding_view.dart';
import 'package:labouchee/pages/otp/otp_view.dart';
import 'package:labouchee/pages/place_order/place_order.dart';
import 'package:labouchee/pages/product_details/product_details.dart';
import 'package:labouchee/pages/register/register_view.dart';
import 'package:labouchee/pages/review/reviews.dart';

import '../pages/profile/profile.dart';
import '../pages/starting/starting.dart';
import 'auth_guard.dart';

// Defining routes and global transitions
@CustomAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(
      page: LandingView,
      name: 'landingScreenRoute',
    ),
    MaterialRoute(
      page: RegisterView,
      name: 'registerScreenRoute',
    ),
    MaterialRoute(
      page: LoginView,
      name: 'loginScreenRoute',
    ),
    MaterialRoute(
      page: ForgotView,
      name: 'forgotScreenRoute',
    ),
    MaterialRoute(
      page: OtpView,
      name: 'otpScreenRoute',
    ),
    MaterialRoute(
      page: OnboardingView,
      name: 'onboardingScreenRoute',
    ),
    MaterialRoute(
      page: LanguageView,
      name: 'languageScreenRoute',
    ),
    MaterialRoute(
      page: Starting,
      name: 'startingScreenRoute',
    ),
    MaterialRoute(
      page: ProductDetailPage,
      name: 'productScreenRoute',
    ),
    MaterialRoute(
      page: CheckOut,
      name: 'checkoutScreenRoute',
    ),
    MaterialRoute(
      page: PlaceOrder,
      name: 'placeOrderScreenRoute',
    ),
    MaterialRoute(
      page: Reviews,
      name: 'reviewsScreenRoute',
    ),
    MaterialRoute(
      page: Profile,
      name: 'profileScreenRoute',
    ),
    MaterialRoute(
      page: Branches,
      name: 'branchesScreenRoute',
    ),
    MaterialRoute(
      page: CustomerSupport,
      name: 'customerSupportScreenRoute',
    ),
    MaterialRoute(
      page: Coupons,
      name: 'couponsSupportScreenRoute',
    ),
    MaterialRoute(
      page: CategoriesListing,
      name: 'categoriesListingScreenRoute',
    ),
    MaterialRoute(
      page: CategoryProductListing,
      name: 'categoryProductListingScreenRoute',
    ),
    MaterialRoute(
      page: MyOrders,
      name: 'myOrdersScreenRoute',
    ),
    MaterialRoute(
      page: MyOrderDetailPage,
      name: 'myOrdersDetailScreenRoute',
    ),
  ],
  transitionsBuilder: TransitionsBuilders.zoomIn,
  durationInMilliseconds: 400,
)
class $Router {}
