import 'package:flutter/cupertino.dart';
import 'package:labouchee/services/language_service.dart';
import 'package:stacked/stacked.dart';

import '../app/locator.dart';

abstract class LanguageAwareBaseView extends BaseViewModel {
  final LanguageService _languageService = locator<LanguageService>();

  LanguageAwareBaseView() : super() {
    _languageService.locale.listen(
      (event) {
        onLanguageChanged(event);
      },
    );
  }

  void onLanguageChanged(Locale newLocale);
}
