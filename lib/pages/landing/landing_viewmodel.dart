import 'package:labouchee/app/routes.gr.dart';
import 'package:labouchee/models/user.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/locator.dart';
import '../../services/api/labouchee_api.dart';

class LandingVM extends BaseViewModel {
  final _laboucheeAPI = locator<LaboucheeAPI>();
  final _snackbarService = locator<SnackbarService>();
  final _navigationService = locator<NavigationService>();

  Future<void> initialize() async {
    Future<void> _initialize() async {
      try {
        UserModel user = await _laboucheeAPI.getUser();

        if (user.numberVerifiedAt == null) {
          _navigationService.clearStackAndShow(Routes.otpScreenRoute);
        }
      } catch (e) {
        setError(e.toString());
        _snackbarService.showSnackbar(
          message: e.toString(),
        );
      }
    }

    await runBusyFuture(_initialize(),);
  }
}
