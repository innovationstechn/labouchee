import 'package:flutter/material.dart';
import 'package:labouchee/app/locator.dart';
import 'package:labouchee/app/routes.gr.dart';
import 'package:labouchee/services/language_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LanguageVM extends BaseViewModel{
  final _navigationService = locator<NavigationService>();
  final _languageService = locator<LanguageService>();

  Future<void> languageSelection(String language, String nextPage) async {
    await _languageService.changeLanguage(Locale(language));
    _navigationService.clearStackAndShow(nextPage);
  }
  void update(){
    notifyListeners();
  }
}