import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:labouchee/app/locator.dart';
import 'package:labouchee/services/local_storage/hive_local_storage.dart';
import 'package:labouchee/services/local_storage/local_storage.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/routes.gr.dart';

Future<PageRouteInfo> generateInitRoute() async {
  final LocalStorage localStorage = locator<HiveLocalStorage>();

  final isOnboardingDone = await localStorage.onboardingDone();
  final isLoggedIn = await localStorage.token() != null;
  // final isOtpVerified = await localStorage.isOtpVerified();

  if(!isOnboardingDone) {
    return OnboardingScreenRoute();
  } else if(!isLoggedIn) {
    return LoginScreenRoute();
  }
  // else if(!isOtpVerified) {
  //   return Routes.otpScreenRoute;
  // }
  else {
    return StartingScreenRoute();
  }
}

Future<String?> uniqueDeviceIdentifier() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  if(Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    return androidInfo.androidId;
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

    return iosInfo.identifierForVendor;
  } else if(kIsWeb) {
    WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;

    if(webBrowserInfo.vendor == null) return null;
    if(webBrowserInfo.userAgent == null) return null;

    return webBrowserInfo.vendor! + webBrowserInfo.userAgent! + webBrowserInfo.hardwareConcurrency.toString();
  } else {
    throw 'Platform not supported';
  }
}