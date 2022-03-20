import 'package:labouchee/models/inquiry.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/locator.dart';
import '../../services/api/labouchee_api.dart';

class CustomerSupportVM extends BaseViewModel {
  final _snackbarService = locator<SnackbarService>();
  final _api = locator<LaboucheeAPI>();

  Future<void> submit(String subject, String inquiry) async {
    Future<void> _submit() async {
      try {
        final message = await _api
            .submitInquiry(InquiryModel(subject: subject, message: inquiry));
        _snackbarService.showSnackbar(message: message);
      } catch (e) {
        _snackbarService.showSnackbar(message: e.toString());
      }
    }

    await runBusyFuture(_submit());
  }
}
