import 'package:labouchee/app/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/routes.gr.dart';
import '../../services/local_storage/hive_local_storage.dart';

class OnboardingVM extends BaseViewModel {
  List<String> get images => [
        'assets/images/onboarding/onboarding_1.jpg',
        'assets/images/onboarding/onboarding_2.jpg',
        'assets/images/onboarding/onboarding_3.jpg',
      ];

  final _navigationService = locator<NavigationService>();
  final _storageService = locator<HiveLocalStorage>();

  Future<void> init() async {
    Future<void> _init() async {
      final onboardingDone = await _storageService.onboardingDone();

      if(onboardingDone) {
        await _navigationService.navigateTo(Routes.languageScreenRoute);
      }
    }

    await runBusyFuture(_init());
  }

  void onUserDone() async {
    await _storageService.onboardingDone(isDone: true);
    await _navigationService.clearStackAndShow(Routes.languageScreenRoute);
  }
}
