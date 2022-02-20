import 'package:labouchee/app/locator.dart';
import 'package:labouchee/services/local_storage/hive_local_storage.dart';
import 'package:labouchee/services/local_storage/local_storage.dart';

import '../app/routes.gr.dart';

Future<String> generateInitRoute() async {
  final LocalStorage localStorage = locator<HiveLocalStorage>();

  final isOnboardingDone = await localStorage.onboardingDone();
  final isLoggedIn = await localStorage.token() != null;
  // final isOtpVerified = await localStorage.isOtpVerified();

  if(!isOnboardingDone) {
    return Routes.onboardingScreenRoute;
  } else if(!isLoggedIn) {
    return Routes.loginScreenRoute;
  }
  // else if(!isOtpVerified) {
  //   return Routes.otpScreenRoute;
  // }
  else {
    return Routes.startingScreenRoute;
  }
}