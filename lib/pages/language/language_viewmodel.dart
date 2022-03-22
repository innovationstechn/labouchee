import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:labouchee/app/locator.dart';
import 'package:labouchee/app/routes.gr.dart';
import 'package:labouchee/services/language_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../services/navigator.dart';

class LanguageVM extends BaseViewModel {
  final _navigationService = locator<NavigatorService>();
  final _languageService = locator<LanguageService>();

  Future<void> languageSelection(
      String language, PageRouteInfo nextPage) async {
    await _languageService.changeLanguage(Locale(language));
    // _navigationService.router.replaceAll([LanguageScreenRoute(nextPage: StartingScreenRoute())]);
    _navigationService.router.replace(nextPage);
    // _navigationService.router.pop();
    // _navigationService.router.replaceAll([nextPage]);
  }

  void update() {
    notifyListeners();
  }
}
