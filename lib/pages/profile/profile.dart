import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labouchee/mixins/validator_mixin.dart';
import 'package:labouchee/widgets/custom_app_bar.dart';
import 'package:labouchee/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../widgets/address_field.dart';
import '../../widgets/contact_number_field.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';

class Profile extends StatefulWidget with ValidatorMixin {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController email = TextEditingController(text: "Email"),
      name = TextEditingController(text: "Name"),
      address = TextEditingController(text: "Address"),
      phoneNumber = TextEditingController(text: "Phone Number"),
      postalCode = TextEditingController(text: "Postal Code");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(title: "Profile",),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    const CircleAvatar(
                      radius: 65,
                      backgroundImage: AssetImage(
                        "assets/images/flags/sa_flag.jpg",
                      ),
                    ),
                    Positioned(
                      width: 40,
                      height: 40,
                      top: 80,
                      right: 0,
                      child: Container(
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                        ),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormWidget(
              context: context,
              textEditingController: name,
              labelText: AppLocalizations.of(context)!.name,
              focusNode: FocusNode(),
              // errorText: registerValidationErrorModel.name != null
              //     ? registerValidationErrorModel.name!.first
              //     : null,
              validationMethod: (text) => widget.nameValidator(text),
            ),
            TextFormWidget(
              context: context,
              textEditingController: email,
              labelText: AppLocalizations.of(context)!.email,
              focusNode: FocusNode(),
              // errorText: registerValidationErrorModel.email != null
              //     ? registerValidationErrorModel.email!.first
              //     : null,
              validationMethod: (text) => widget.emailValidator(text),
            ),
            AddressFormWidget(
              context: context,
              textEditingController: address,
              labelText: "Address",
              focusNode: FocusNode(),
              // errorText:
              // registerValidationErrorModel.address1 != null
              //     ? registerValidationErrorModel.address1!.first
              //     : null,
              validationMethod: (text) => widget.addressValidator(text),
            ),
            ContactFormWidget(
              context: context,
              textEditingController: phoneNumber,
              labelText: AppLocalizations.of(context)!.contactNo,
              bottomText: "CONTACT NUMBER SHOULD BE LIKE (0966)",
              initialValue: "0966",
              // errorText: registerValidationErrorModel.contactNo !=
              //     null
              //     ? registerValidationErrorModel.contactNo!.first
              //     : null,
              focusNode: FocusNode(),
              validationMethod: (text) => widget.contactNoValidator(text),
            ),
            SizedBox(
              height: 1.h,
            ),
            CustomButton(
              padding: EdgeInsets.all(2.w),
              buttonColor: Theme.of(context).primaryColor,
              textColor: Colors.white,
              text: "Save",
              size: Size(80.w, 7.h),
              textFontSize: 12.sp,
              onTap: () => onSavePressed(),
            ),
            SizedBox(
              height: 1.5.h,
            ),
          ],
        ),
      ),
    ));
  }

  void onSavePressed() {}
}
