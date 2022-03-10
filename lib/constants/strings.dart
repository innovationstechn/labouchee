import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stacked_services/stacked_services.dart';

class Strings {
  static AppLocalizations get _localizations =>
      AppLocalizations.of(StackedService.navigatorKey!.currentContext!)!;

  static String get unknownError => _localizations.unknownError;

  static String get noInternet => _localizations.noInternet;

  static String get cantLogin => _localizations.cantLogin;

  static String get cantServeRequest => _localizations.cantServeRequest;

  static String get cantGetProduct => _localizations.cantGetProduct;

  static String get paymentProcessError => _localizations.paymentProcessError;
}
