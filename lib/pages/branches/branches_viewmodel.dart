import 'package:labouchee/models/branch.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/locator.dart';
import '../../services/api/labouchee_api.dart';

class BranchesVM extends BaseViewModel {
  final _laboucheeAPI = locator<LaboucheeAPI>();
  final _snackbarService = locator<SnackbarService>();

  List<BranchModel> _branches = [];
  List<BranchModel> get branches => _branches;

  Future<void> initialize() async {
    Future<void> _initialize() async {
      try {
        _branches = await _laboucheeAPI.getBranches();
      } catch (e) {
        _snackbarService.showSnackbar(message: e.toString());
      }
    }

    await runBusyFuture(_initialize());
  }
}
