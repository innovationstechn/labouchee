import 'package:labouchee/app/routes.gr.dart';
import 'package:labouchee/services/local_storage/hive_local_storage.dart';
import 'package:labouchee/services/navigator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/locator.dart';
import '../../models/user.dart';
import '../../services/user_service.dart';

class StartingStreamVM extends StreamViewModel<UserModel> {
  final _userService = locator<UserService>();
  final _navigationService = locator<NavigatorService>();
  final _storageService = locator<HiveLocalStorage>();
  final _snackbarService = locator<SnackbarService>();

  Future<void> refresh() async {
    Future<void> _loadData() async {
      try {
        await _userService.fetch();
      } catch (e) {
        _snackbarService.showSnackbar(message: e.toString());
      }
    }

    await runBusyFuture(_loadData());
  }

  void logout() async {
    await _storageService.clearToken();

    await _navigationService.router.replaceAll([LoginScreenRoute()]);
  }

  @override
  Stream<UserModel> get stream => _userService.userState;
}
