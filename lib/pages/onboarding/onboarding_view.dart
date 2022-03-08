import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:labouchee/pages/onboarding/onboarding_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:onboarding/onboarding.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnboardingView extends StatelessWidget {
  OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ViewModelBuilder<OnboardingVM>.reactive(
          viewModelBuilder: () => OnboardingVM(),
          onModelReady: (model) async => await model.init(),
          builder: (context, onboardingVM, _) {
            if (onboardingVM.isBusy) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              );
            }

            return IntroductionScreen(
              globalBackgroundColor: Colors.white,
              isBottomSafeArea: true,
              isTopSafeArea: true,
              showNextButton: false,
              pages: onboardingVM.images
                  .map(
                    (e) => PageViewModel(
                      decoration: const PageDecoration(
                        bodyFlex: 0,
                        imageFlex: 1,
                      ),
                      titleWidget: const SizedBox(),
                      bodyWidget: Container(),
                      image: Center(
                        child: Image.asset(
                          e,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onDone: onboardingVM.onUserDone,
              showSkipButton: true,
              skip:
                  Icon(Icons.skip_next, color: Theme.of(context).primaryColor),
              next: Icon(
                Icons.navigate_next,
                color: Theme.of(context).primaryColor,
              ),
              done: Text(
                AppLocalizations.of(context)!.login,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              dotsDecorator: DotsDecorator(
                size: const Size.square(10.0),
                activeSize: const Size(20.0, 10.0),
                activeColor: Theme.of(context).primaryColor,
                color: Colors.black26,
                spacing: const EdgeInsets.symmetric(
                  horizontal: 3.0,
                ),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            );

          },
        ),
      ),
    );
  }
}
