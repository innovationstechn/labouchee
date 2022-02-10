import 'package:injectable/injectable.dart';
import 'package:labouchee/services/api/labouchee_api.dart';
import 'package:labouchee/services/language_service.dart';
import 'package:labouchee/services/local_storage/hive_local_storage.dart';
import 'package:stacked_services/stacked_services.dart';

@module
abstract class ThirdPartyServicesModule {
  @lazySingleton
  NavigationService get navigationService;
  @lazySingleton
  DialogService get dialogService;
  @lazySingleton
  SnackbarService get snackbarService;
  @lazySingleton
  BottomSheetService get bottomSheetService;
  @lazySingleton
  LaboucheeAPI get api;
  @lazySingleton
  HiveLocalStorage get storage;
  @lazySingleton
  LanguageService get languageService;
}
