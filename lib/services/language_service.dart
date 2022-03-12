import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:labouchee/app/locator.dart';
import 'package:labouchee/constants/general.dart';
import 'package:labouchee/services/local_storage/local_storage.dart';
import 'local_storage/hive_local_storage.dart';

class LanguageService {
  final LocalStorage _storage = locator<HiveLocalStorage>();
  final StreamController<Locale> _localeController =
      StreamController.broadcast();

  Stream<Locale> get locale => _localeController.stream;

  LanguageService() {
    _localeController.add(DEFAULT_LOCALE);

    Future<void> _lastSavedLocale() async {
      final String? locale = await _storage.locale();

      if (locale == null) return;

      _localeController.add(Locale(locale));
    }

    _lastSavedLocale();
  }

  Future<void> changeLanguage(Locale newLocale) async {
    await _storage.locale(localeString: newLocale.languageCode);

    _localeController.add(newLocale);
  }
}
