import 'package:flutter/material.dart';
import 'package:labouchee/models/register_error_model.dart';
import 'package:labouchee/pages/register/register_viewmodel.dart';
import 'package:labouchee/widgets/address_field.dart';
import 'package:labouchee/widgets/contact_number_field.dart';
import 'package:stacked/stacked.dart';
import 'package:labouchee/mixins/validator_mixin.dart';
import 'package:labouchee/widgets/custom_button.dart';
import 'package:labouchee/widgets/custom_text.dart';
import 'package:labouchee/widgets/custom_text_form_field.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterView extends StatefulWidget with ValidatorMixin {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _signUpFormKey = GlobalKey<FormState>();

  final TextEditingController email = TextEditingController(),
      password = TextEditingController(),
      name = TextEditingController(),
      address = TextEditingController(),
      phoneNumber = TextEditingController(),
      postalCode = TextEditingController();
  final bool signUpError = false;

  RegisterValidationErrorModel registerValidationErrorModel =
      RegisterValidationErrorModel(
          name: null,
          email: null,
          password: null,
          address1: null,
          address2: null,
          zipCode: null,
          contactNo: null);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterVM>.reactive(
      viewModelBuilder: () => RegisterVM(),
      onModelReady: (model) {},
      builder: (context, registerVM, _) {
        return Form(
          key: _signUpFormKey,
          child: Scaffold(
            body: Center(
              child: CustomScrollView(slivers: [
                SliverAppBar(
                  centerTitle: true,
                  title: Text(AppLocalizations.of(context)!.signUp),
                  toolbarHeight: 8.h,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    SizedBox(
                      height: 5.h,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: "Create Account",
                          fontSize: 25.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        TextFormWidget(
                          context: context,
                          textEditingController: name,
                          labelText: AppLocalizations.of(context)!.name,
                          focusNode: FocusNode(),
                          errorText: registerValidationErrorModel.name != null
                              ? registerValidationErrorModel.name!.first
                              : null,
                          validationMethod: (text) =>
                              widget.nameValidator(text),
                        ),
                        TextFormWidget(
                          context: context,
                          textEditingController: email,
                          labelText: AppLocalizations.of(context)!.email,
                          focusNode: FocusNode(),
                          errorText: registerValidationErrorModel.email != null
                              ? registerValidationErrorModel.email!.first
                              : null,
                          validationMethod: (text) =>
                              widget.emailValidator(text),
                        ),
                        TextFormWidget(
                          context: context,
                          textEditingController: password,
                          labelText: AppLocalizations.of(context)!.password,
                          obscureText: true,
                          showIcon: true,
                          errorText:
                              registerValidationErrorModel.password != null
                                  ? registerValidationErrorModel.password!.first
                                  : null,
                          focusNode: FocusNode(),
                          validationMethod: (text) =>
                              widget.passwordValidator(text),
                        ),
                        AddressFormWidget(
                          context: context,
                          textEditingController: address,
                          labelText: "Address",
                          focusNode: FocusNode(),
                          errorText:
                              registerValidationErrorModel.address1 != null
                                  ? registerValidationErrorModel.address1!.first
                                  : null,
                          validationMethod: (text) =>
                              widget.addressValidator(text),
                        ),
                        TextFormWidget(
                          context: context,
                          textEditingController: postalCode,
                          labelText: "Postal Code",
                          errorText:
                              registerValidationErrorModel.zipCode != null
                                  ? registerValidationErrorModel.zipCode!.first
                                  : null,
                          focusNode: FocusNode(),
                          validationMethod: (text) =>
                              widget.postalCodeValidator(text),
                        ),
                        ContactFormWidget(
                          context: context,
                          textEditingController: phoneNumber,
                          labelText: AppLocalizations.of(context)!.contactNo,
                          bottomText: "CONTACT NUMBER SHOULD BE LIKE (0966)",
                          initialValue: "0966",
                          errorText: registerValidationErrorModel.contactNo !=
                                  null
                              ? registerValidationErrorModel.contactNo!.first
                              : null,
                          focusNode: FocusNode(),
                          validationMethod: (text) =>
                              widget.contactNoValidator(text),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        if (registerVM.isBusy)
                          CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          )
                        else
                          CustomButton(
                            padding: EdgeInsets.all(2.w),
                            buttonColor: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            text: AppLocalizations.of(context)!.signUp,
                            size: Size(80.w, 7.h),
                            textFontSize: 12.sp,
                            onTap: () => onSignUpPressed(registerVM),
                          ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                      ],
                    )
                  ]),
                )
              ]),
            ),
          ),
        );
      },
    );
  }

  Future<void> onSignUpPressed(RegisterVM registerVM) async {
    if (_signUpFormKey.currentState!.validate()) {
      await registerVM.register(
        name: name.text,
        email: email.text,
        password: password.text,
        address1: address.text,
        address2: '',
        zipCode: postalCode.text,
        contactNo: phoneNumber.text.replaceAll(RegExp(r' '), r""),
      );
      if (registerVM.hasError) {
        registerValidationErrorModel =
            registerVM.error(registerVM) as RegisterValidationErrorModel;
        registerVM.setState();
      }else{
        registerVM.navigateToOTPVerification();
      }
    }
  }
}
