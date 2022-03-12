import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:labouchee/pages/onboarding/onboarding_viewmodel.dart';
import 'package:labouchee/widgets/custom_circular_progress_indicator.dart';
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
                child: CustomCircularProgressIndicator(),
              );
            }

            return IntroductionScreen(
              scrollPhysics: const ScrollPhysics(),
              globalBackgroundColor: Colors.white,
              isBottomSafeArea: true,
              isTopSafeArea: true,
              pages: onboardingVM.images
                  .map(
                    (e) => PageViewModel(
                      decoration: const PageDecoration(
                        bodyFlex: 0,
                        imageFlex: 1,
                        fullScreen: true,
                        imagePadding: EdgeInsets.zero,
                        contentMargin: EdgeInsets.zero,
                      ),
                      titleWidget: const SizedBox(),
                      bodyWidget: Container(),
                      image: SizedBox(
                        width: double.infinity,
                        child: GestureDetector(
                          onTap: () {
                            if (e == onboardingVM.images.last)
                              onboardingVM.onUserDone();
                          },
                          child: Image.asset(
                            e,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onDone: onboardingVM.onUserDone,
              showNextButton: false,
              showSkipButton: false,
              showDoneButton: false,
            );
          },
        ),
      ),
    );
  }
}
