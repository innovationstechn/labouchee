import 'package:injectable/injectable.dart';
import 'package:labouchee/services/api/labouchee_api.dart';
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
}
