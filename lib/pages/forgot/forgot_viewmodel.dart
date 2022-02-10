import 'dart:developer';

import 'package:labouchee/models/reset_password_model.dart';
import 'package:labouchee/services/api/exceptions/api_exceptions.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/locator.dart';
import '../../app/routes.gr.dart';
import '../../models/reset_password_error_model.dart';
import '../../services/api/api.dart';
import '../../services/api/labouchee_api.dart';

class ForgotVM extends BaseViewModel {
  final API _api = locator<LaboucheeAPI>();
  final NavigationService _navigationService = locator();
  final SnackbarService _snackbarService = locator();

  bool _takeOTPCode = false;
  bool get takeOTPCode => _takeOTPCode;

  Future<void> forgot(String email) async {
    Future<void> _forgot() async {
      try {
        final code = await _api.forgotPassword(email);

        log('OTP code is $code');
        _snackbarService.showSnackbar(message: 'OTP code is $code');

        _takeOTPCode = true;
      } catch (e) {
        _snackbarService.showSnackbar(
          message: e.toString(),
        );
      }
    }

    await runBusyFuture(_forgot());
  }

  Future<void> reset(String email, String password, String code) async {
    Future<void> _reset() async {
      try {
        final model = ResetPasswordModel(
          email: email,
          password: password,
          code: code,
        );

        await _api.resetPassword(model);

        _navigationService.clearStackAndShow(Routes.loginScreenRoute);
      } on ErrorModelException<ResetPasswordErrorModel> catch (e) {
        _snackbarService.showSnackbar(message: e.toString());
        setError(e.error);
        log(e.error.toJson().toString());
      } catch (e) {
        _snackbarService.showSnackbar(message: e.toString());
      }
    }

    await runBusyFuture(_reset());
  }
}
