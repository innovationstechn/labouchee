import 'package:flutter/material.dart';
import 'package:labouchee/pages/otp/otp_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/cupertino.dart';
import 'package:labouchee/widgets/custom_button.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import '../../widgets/custom_circular_progress_indicator.dart';

class OtpView extends StatelessWidget {
  OtpView({Key? key}) : super(key: key);
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewModelBuilder<OtpVM>.reactive(
        viewModelBuilder: () => OtpVM(),
        onModelReady: (model) => model.sendOTP(),
        builder: (context, otpVM, _) {
          if (otpVM.isBusy) {
            return const Center(
              child: CustomCircularProgressIndicator(),
            );
          }

          return otpField(otpVM, context);
        },
      ),
    );
  }

  Widget otpField(OtpVM otpVM, BuildContext context) {
    return DoubleBack(
      onFirstBackPress: (context){
        otpVM.goBackToLogin();
      },
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/animations/forgotpassword.json',
                    width: 200,
                    height: 200,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    AppLocalizations.of(context)!.otpVerification,
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    AppLocalizations.of(context)!
                        .enterInformationBelowToResetPassword,
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: PinCodeTextField(
                      focusNode: FocusNode(),
                      length: 5,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        inactiveFillColor: Colors.white,
                        inactiveColor: Theme.of(context).primaryColor,
                        selectedColor: Theme.of(context).primaryColor,
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        selectedFillColor: Theme.of(context).primaryColor,
                        activeFillColor: Colors.white,
                      ),
                      animationDuration: const Duration(milliseconds: 300),
                      // backgroundColor: Colors.white,
                      enableActiveFill: false,
                      // errorAnimationController: errorController,
                      controller: otpController,
                      onCompleted: (v) {
                        print("Completed");
                      },
                      onChanged: (value) {
                        print(value);
                      },
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                      appContext: context,
                    ),
                  ),
                  CustomButton(
                    padding: EdgeInsets.all(2.w),
                    buttonColor: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    text: AppLocalizations.of(context)!.submit,
                    size: Size(80.w, 7.h),
                    textFontSize: 12.sp,
                    onTap: () => onSubmitPressed(otpVM),
                  ),
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Future<void> onSubmitPressed(OtpVM vM) async {
    vM.match(otpController.text);
  }
}
