import 'dart:ui';

import 'package:labouchee/constants/general.dart';
import 'package:labouchee/utils/language_aware_base_view.dart';

class LanguageVM extends LanguageAwareBaseView {
  Locale _locale = DEFAULT_LOCALE;
  Locale get locale => _locale;

  @override
  void onLanguageChanged(Locale newLocale) {
    _locale = newLocale;
    notifyListeners();
  }
}