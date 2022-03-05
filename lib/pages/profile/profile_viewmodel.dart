import 'package:labouchee/models/update_profile.dart';
import 'package:labouchee/models/user.dart';
import 'package:labouchee/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/locator.dart';
import '../../services/api/labouchee_api.dart';

class ProfileVM extends BaseViewModel {
  final _snackbarService = locator<SnackbarService>();
  final _userService = locator<UserService>();
  final _api = locator<LaboucheeAPI>();

  Stream<UserModel> get userState => _userService.userState;

  Future<void> loadData() async {
    Future<void> _loadData() async {
      try {
        await _userService.fetch();
      } catch (e) {
        _snackbarService.showSnackbar(message: e.toString());
      }
    }

    await runBusyFuture(_loadData());
  }

  Future<void> update(String name, String avatar, String contactNo1,
      String contactNo2, String address1, String address2) async {
    Future<void> _update() async {
      try {
        final update = UpdateProfileModel(
            name: name,
            avatar: avatar,
            contactNo1: contactNo1,
            contactNo2: contactNo2,
            address1: address1,
            address2: address2);

        final message = await _api.updateProfile(update);

        _snackbarService.showSnackbar(message: message);

        await loadData();
      } catch (e) {
        _snackbarService.showSnackbar(message: e.toString());
      }
    }

    await runBusyFuture(_update());
  }
}
