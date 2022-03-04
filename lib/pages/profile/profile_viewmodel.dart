import 'package:labouchee/models/user.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/locator.dart';
import '../../services/api/labouchee_api.dart';

class ProfileVM extends BaseViewModel {
  final _snackbarService = locator<SnackbarService>();
  final _api = locator<LaboucheeAPI>();

  UserModel? _user;
  UserModel? get user => _user;

  Future<void> loadData() async {
    Future<void> _loadData() async {
      try {
        _user = await _api.getUser();
      } catch (e) {
        _snackbarService.showSnackbar(message: e.toString());
      }
    }

    await runBusyFuture(_loadData());
  }
}