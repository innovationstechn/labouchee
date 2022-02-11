import 'package:labouchee/app/locator.dart';
import 'package:labouchee/app/routes.gr.dart';
import 'package:labouchee/models/register_model.dart';
import 'package:labouchee/models/register_error_model.dart';
import 'package:labouchee/services/api/exceptions/api_exceptions.dart';
import 'package:labouchee/services/api/labouchee_api.dart';
import 'package:labouchee/services/local_storage/hive_local_storage.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RegisterVM extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _localStorage = locator<HiveLocalStorage>();
  final _laboucheeAPI = locator<LaboucheeAPI>();
  final _snackbarService = locator<SnackbarService>();

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String address1,
    required String address2,
    required String zipCode,
    required String contactNo,
  }) async {
    Future<void> _register() async {
      clearErrors();

      final model = RegisterModel(
        name: name,
        email: email,
        contactNo: contactNo,
        address2: address2,
        address1: address1,
        zipCode: zipCode,
        password: password,
      );

      try {
        final token = await _laboucheeAPI.register(model);

        await _localStorage.token(token: token);

        // _navigationService.navigateTo(Routes.forgotScreenRoute);
      } on ErrorModelException<RegisterValidationErrorModel> catch (e) {
        _snackbarService.showSnackbar(message: e.message);
        setError(e.error);
      } on RequestFailureException catch (e) {
        _snackbarService.showSnackbar(
          message: e.toString(),
        );
      } catch (e) {
        _snackbarService.showSnackbar(
          message: "Oops, we encountered an unknown error",
        );
      }
    }

    await runBusyFuture(_register());
  }


  void navigateToOTPVerification(){
    _navigationService.navigateTo(Routes.otpScreenRoute);
  }

  void setState(){
    clearErrors();
    notifyListeners();
  }
}
