import 'package:flutter/material.dart';
import 'package:labouchee/mixins/validator_mixin.dart';
import 'package:labouchee/models/reset_password_error_model.dart';
import 'package:labouchee/widgets/custom_text.dart';
import 'package:stacked/stacked.dart';
import 'package:labouchee/widgets/custom_button.dart';
import 'package:labouchee/widgets/custom_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';
import 'package:lottie/lottie.dart';
import 'forgot_viewmodel.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgotView extends StatelessWidget with ValidatorMixin {
  ForgotView({Key? key}) : super(key: key);
  final TextEditingController otpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  ResetPasswordErrorModel resetPasswordErrorModel =
      ResetPasswordErrorModel(email: null, password: null, code: null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewModelBuilder<ForgotVM>.reactive(
        viewModelBuilder: () => ForgotVM(),
        builder: (context, forgotVM, _) {
          if (forgotVM.isBusy) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (forgotVM.takeOTPCode) {
            return otpPassFields(forgotVM, context);
          } else {
            return emailField(forgotVM, context);
          }
        },
      ),
    );
  }

  Widget emailField(ForgotVM forgotVM, BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/animations/forgotpassword.json',
            width: 200,
            height: 200,
            fit: BoxFit.fill,
          ),
          const SizedBox(height: 10),
          CustomText(
            text: AppLocalizations.of(context)!.resetPassword,
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomText(
            text: AppLocalizations.of(context)!.enterInformationBelowToResetPassword,
            fontSize: 12.sp,
            fontWeight: FontWeight.normal,
            color: Colors.grey,
          ),
          const SizedBox(height: 20),
          TextFormWidget(
            context: context,
            textEditingController: emailController,
            labelText: AppLocalizations.of(context)!.email,
            focusNode: FocusNode(),
            validationMethod: (text) => emailValidator(text),
          ),
          CustomButton(
            padding: EdgeInsets.all(2.w),
            buttonColor: Theme.of(context).primaryColor,
            textColor: Colors.white,
            text: AppLocalizations.of(context)!.send,
            size: Size(80.w, 7.h),
            textFontSize: 12.sp,
            onTap: () => onEmailSubmitPressed(forgotVM),
          ),
        ],
      ),
    );
  }

  Widget otpPassFields(ForgotVM forgotVM, BuildContext context) {
    return CustomScrollView(
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
                CustomText(
                  text: AppLocalizations.of(context)!.otpVerification,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomText(
                    text: AppLocalizations.of(context)!.enterInformationBelowToResetPassword,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                    padding: EdgeInsets.symmetric(horizontal: 10)),
                const SizedBox(height: 20),
                TextFormWidget(
                  context: context,
                  errorText: resetPasswordErrorModel.code != null
                      ? resetPasswordErrorModel.code!.first
                      : null,
                  textEditingController: otpController,
                  labelText: AppLocalizations.of(context)!.otp,
                  focusNode: FocusNode(),
                  validationMethod: (text) => passwordValidator(text),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormWidget(
                  context: context,
                  errorText: resetPasswordErrorModel.password != null
                      ? resetPasswordErrorModel.password!.first
                      : null,
                  textEditingController: passwordController,
                  labelText: AppLocalizations.of(context)!.password,
                  focusNode: FocusNode(),
                  validationMethod: (text) => passwordValidator(text),
                ),
                CustomButton(
                  padding: EdgeInsets.all(2.w),
                  buttonColor: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  text: AppLocalizations.of(context)!.submit,
                  size: Size(80.w, 7.h),
                  textFontSize: 12.sp,
                  onTap: () => onOtpSubmitPressed(forgotVM),
                ),
              ],
            ),
          ]),
        ),
      ],
    );
  }

  Future<void> onOtpSubmitPressed(ForgotVM forgotVM) async {
    await forgotVM.reset(
        emailController.text, passwordController.text, otpController.text);
    if (forgotVM.hasError) {
      resetPasswordErrorModel =
          forgotVM.error(forgotVM) as ResetPasswordErrorModel;
    }
  }

  Future<void> onEmailSubmitPressed(ForgotVM vM) async {
    String? text = emailValidator(emailController.text);
    if (text == null) {
      vM.forgot(emailController.text);
    } else {
      // Show SnackBar
    }
  }
}
