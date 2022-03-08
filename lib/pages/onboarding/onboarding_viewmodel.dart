import 'package:labouchee/app/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/routes.gr.dart';
import '../../services/local_storage/hive_local_storage.dart';
import '../../services/navigator.dart';

class OnboardingVM extends BaseViewModel {
  List<String> get images => [
        'assets/images/onboarding/onboarding_1.jpeg',
        'assets/images/onboarding/onboarding_2.jpeg',
        'assets/images/onboarding/onboarding_3.jpeg',
      ];

  final _navigationService = locator<NavigatorService>();
  final _storageService = locator<HiveLocalStorage>();

  Future<void> init() async {
    Future<void> _init() async {
      final onboardingDone = await _storageService.onboardingDone();

      if (onboardingDone) {
        await _navigationService.router.navigate(LandingScreenRoute());
      }
    }

    await runBusyFuture(_init());
  }

  void onUserDone() async {
    await _storageService.onboardingDone(isDone: true);
    _navigationService.router.replace(
      LanguageScreenRoute(
        nextPage: LoginScreenRoute(),
      ),
    );
  }
}
