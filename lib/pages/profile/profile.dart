import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:labouchee/mixins/validator_mixin.dart';
import 'package:labouchee/models/user.dart';
import 'package:labouchee/pages/profile/profile_viewmodel.dart';
import 'package:labouchee/widgets/custom_app_bar.dart';
import 'package:labouchee/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stacked/stacked.dart';
import '../../widgets/address_field.dart';
import '../../widgets/contact_number_field.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget with ValidatorMixin {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final ImagePicker _picker = ImagePicker();
  XFile? pickedFile;
  final TextEditingController email = TextEditingController(text: "Email"),
      name = TextEditingController(text: "Name"),
      address = TextEditingController(text: "Address"),
      phoneNumber = TextEditingController(text: "Phone Number"),
      postalCode = TextEditingController(text: "Postal Code");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: CustomAppBar(
        title: "Profile",
      ),
      body: SingleChildScrollView(
        child: ViewModelBuilder<ProfileVM>.reactive(
            viewModelBuilder: () => ProfileVM(),
            onModelReady: (model) async {
              await model.loadData();
            },
            builder: (context, profileVM, _) {
              if (profileVM.isBusy) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              email.text = profileVM.data?.email ?? "";
              name.text = profileVM.data?.name ?? "";
              address.text = profileVM.data?.address?.first ?? "";
              phoneNumber.text = profileVM.data?.contactNo ?? "";
              postalCode.text = profileVM.data?.zipCode ?? "";

              return Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          pickedFile != null
                              ? CircleAvatar(
                                  radius: 65,
                                  backgroundImage:
                                      FileImage(File(pickedFile!.path)))
                              : CircleAvatar(
                                  radius: 65,
                                  backgroundImage: pickedFile != null
                                      ? Image.file(File(pickedFile!.path))
                                          as ImageProvider
                                      : profileVM.data!.avatar != null
                                          ? NetworkImage(
                                              profileVM.data!.avatar!,
                                            ) as ImageProvider
                                          : const AssetImage(
                                                  'assets/images/logo.png')
                                              as ImageProvider,
                                ),
                          Positioned(
                            width: 40,
                            height: 40,
                            top: 80,
                            right: 0,
                            child: Container(
                              child: IconButton(
                                color: Colors.white,
                                onPressed: () {
                                  showPicker();
                                },
                                icon: const Icon(Icons.camera_alt_outlined),
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
                    // TODO, add fields marked with '-'
                    onTap: () => profileVM.update(
                      name.text,
                      pickedFile != null ? File(pickedFile!.path) : null,
                      phoneNumber.text,
                      '-',
                      address.text,
                      '-',
                    ),
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                ],
              );
            }),
      ),
    ));
  }

  Future showPicker() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Select option'),
            content: Container(
              height: 150,
              width: 200,
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.camera_alt_outlined),
                    title: const Text("Camera"),
                    onTap: () async {
                      await _getFromCamera();
                      Navigator.pop(context);
                      setState(() {});
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.broken_image_outlined),
                    title: const Text("Storage"),
                    onTap: () async {
                      await _getFromStorage();
                      Navigator.pop(context);
                      setState(() {});
                    },
                  )
                ],
              ),
            ),
            // actions: <Widget>[
            //   TextButton(
            //     child: const Text('CANCEL'),
            //     onPressed: () {
            //       Navigator.of(context).pop();
            //     },
            //   ),
            // ],
          );
        });
  }

  _getFromCamera() async {
    pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) setState(() {});
  }

  _getFromStorage() async {
    pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
  }
}
