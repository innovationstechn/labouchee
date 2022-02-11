import 'package:flutter/material.dart';
import 'package:labouchee/pages/login/login_viewmodel.dart';
import 'package:labouchee/mixins/validator_mixin.dart';
import 'package:labouchee/widgets/custom_button.dart';
import 'package:labouchee/widgets/custom_text.dart';
import 'package:labouchee/widgets/custom_text_form_field.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatefulWidget with ValidatorMixin {
  LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController email = TextEditingController(),
      password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginVM>.reactive(
      viewModelBuilder: () => LoginVM(),
      onModelReady: (model) {},
      builder: (context, loginVM, _) {

        return Scaffold(
            body: Form(
          key: _formKey,
          child: Center(
            child: CustomScrollView(slivers: [
              SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(
                    height: 15.h,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                          text: AppLocalizations.of(context)!.welComeBack,
                          fontSize: 25.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                          ),
                      SizedBox(
                        height: 1.h,
                      ),
                      CustomText(
                          text: AppLocalizations.of(context)!
                              .signInWithEmailPassword,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                      SizedBox(
                        height: 3.h,
                      ),
                      TextFormWidget(
                        context: context,
                        textEditingController: email,
                        labelText: AppLocalizations.of(context)!.email,
                        focusNode: FocusNode(),
                        validationMethod: (text) => widget.emailValidator(text),
                      ),
                      TextFormWidget(
                        context: context,
                        textEditingController: password,
                        labelText: AppLocalizations.of(context)!.password,
                        obscureText: true,
                        showIcon: true,
                        focusNode: FocusNode(),
                        validationMethod: (text) =>
                            widget.passwordValidator(text),
                      ),
                      Align(
                          alignment: AlignmentDirectional.topStart,
                          child: CustomText(
                              text:
                                  AppLocalizations.of(context)!.forgotPassword,
                              padding:
                                  EdgeInsets.symmetric(horizontal: 5.w,vertical: 5),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w300,
                              onTap:() => onForgotPassword(loginVM))),
                      SizedBox(height: 1.5.h),
                      if(loginVM.isBusy)
                        CircularProgressIndicator(color: Theme.of(context).primaryColor,)
                      else
                      CustomButton(
                        // padding: EdgeInsets.symmetric(vertical: 5),
                        buttonColor: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        text: AppLocalizations.of(context)!.signIn,
                        size: Size(80.w, 7.h),
                        textFontSize: 12.sp,
                        onTap: () => onLoginPressed(loginVM),
                      ),
                      SizedBox(
                        height: 1.5.h,
                      ),
                      createAccount(context,loginVM),
                    ],
                  )
                ]),
              )
            ]),
          ),
        ));
      },
    );
  }

  void onLoginPressed(LoginVM loginVM) {
    if (_formKey.currentState!.validate()) {
      loginVM.login(email.text, password.text);
    }
  }

  void onForgotPassword(LoginVM loginVm){
    loginVm.navigateToForgotPassword();
  }

  Widget createAccount(BuildContext context,LoginVM loginVM) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal:2.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
              text: AppLocalizations.of(context)!.dontHaveAccount+" ",
              fontSize: 14.sp,
              color: Colors.black,
              fontWeight: FontWeight.w400),
          CustomText(
              text: AppLocalizations.of(context)!.signUp,
              fontSize: 14.sp,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w400,
              onTap:()=>loginVM.navigateToSignUp())
        ],
      ),
    );
  }
}
