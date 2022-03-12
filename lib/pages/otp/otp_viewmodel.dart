import 'dart:developer';

import 'package:labouchee/app/locator.dart';
import 'package:labouchee/services/api/api.dart';
import 'package:labouchee/services/api/exceptions/api_exceptions.dart';
import 'package:labouchee/services/api/labouchee_api.dart';
import 'package:labouchee/services/local_storage/hive_local_storage.dart';
import 'package:labouchee/services/local_storage/local_storage.dart';
import 'package:labouchee/services/navigator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/routes.gr.dart';

class OtpVM extends BaseViewModel {
  final API _api = locator<LaboucheeAPI>();
  final NavigatorService _navigationService = locator();
  final SnackbarService _snackbarService = locator();
  final LocalStorage _localStorage = locator<HiveLocalStorage>();

  String? _otpCode;

  Future<void> sendOTP() async {
    Future<void> _sendOTP() async {
      try {
        _otpCode = await _api.sendOTP();
      } on ErrorModelException<int> catch (e) {
        _otpCode = e.error.toString();

        _snackbarService.showSnackbar(message: 'OTP code is $_otpCode');
        log('OTP code is $_otpCode');
        rethrow;
      } catch (e) {
        _snackbarService.showSnackbar(message: e.toString());
      }
    }

    await runBusyFuture(_sendOTP());
  }

  Future<void> match(String userOtpCode) async {
    Future<void> _match() async {
      if (userOtpCode == _otpCode) {
        await _api.verifyUser();
        await _localStorage.isOtpVerified(isVerified: true);

        _navigationService.router.replace(StartingScreenRoute());
      } else {
        _snackbarService.showSnackbar(message: 'Sorry, that OTP didn\'t match');
      }
    }

    await runBusyFuture(_match());
  }
}
