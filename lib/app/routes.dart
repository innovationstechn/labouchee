import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:labouchee/pages/forgot/forgot_view.dart';
import 'package:labouchee/pages/landing/home_view.dart';
import 'package:labouchee/pages/language/language.dart';
import 'package:labouchee/pages/login/login_view.dart';
import 'package:labouchee/pages/onboarding/onboarding_view.dart';
import 'package:labouchee/pages/otp/otp_view.dart';
import 'package:labouchee/pages/register/register_view.dart';

import '../pages/starting/starting.dart';

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

  ],
  transitionsBuilder: TransitionsBuilders.zoomIn,
  durationInMilliseconds: 400,
)
class $Router {}
