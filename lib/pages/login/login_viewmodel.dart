import 'package:labouchee/app/locator.dart';
import 'package:labouchee/app/routes.gr.dart';
import 'package:labouchee/models/login_model.dart';
import 'package:labouchee/services/api/exceptions/api_exceptions.dart';
import 'package:labouchee/services/api/labouchee_api.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../services/local_storage/hive_local_storage.dart';

class LoginVM extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _localStorage = locator<HiveLocalStorage>();
  final _laboucheeAPI = locator<LaboucheeAPI>();
  final _snackbarService = locator<SnackbarService>();

  Future<void> login(String username, String password) async {
    Future<void> _login() async {
      try {
        final token = await _laboucheeAPI.login(
          LoginModel(email: username, password: password),
        );

        await _localStorage.token(token: token);

        _navigationService.navigateTo(Routes.landingScreenRoute);
      } on RequestFailureException catch (e) {
        _snackbarService.showSnackbar(
          message: e.toString(),
        );
      } on UnauthorisedException catch (e) {
        _snackbarService.showSnackbar(
          message: e.toString(),
        );
      } catch (e) {
        _snackbarService.showSnackbar(
            message: 'Sorry, we encountered an unknown error');
      }
    }

    await runBusyFuture(_login());
  }

  void navigateToForgotPassword(){
    _navigationService.navigateTo(Routes.forgotScreenRoute);
  }

  void navigateToSignUp(){
    _navigationService.navigateTo(Routes.registerScreenRoute);
  }
}
