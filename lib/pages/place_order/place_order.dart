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
import 'package:group_radio_button/group_radio_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlaceOrder extends StatefulWidget with ValidatorMixin {
  const PlaceOrder({Key? key}) : super(key: key);

  @override
  _PlaceOrderState createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  final _placeOrderFormKey = GlobalKey<FormState>();

  String _verticalGroupValue = "";
  List<String> _status = [
    "Credit or debit card/paypal",
    "Cash on Delivery",
    "Pick from Branch"
  ];

  String selectedBranch = "";

  final TextEditingController email = TextEditingController(),
      name = TextEditingController(),
      address = TextEditingController(),
      firstPhoneNumber = TextEditingController(),
      secondPhoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Form(
      key: _placeOrderFormKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CustomScrollView(slivers: [
            SliverAppBar(
              leading: BackButton(color: Colors.black),
              title: CustomText(
                text: "Place Order",
                fontWeight: FontWeight.bold,
                fontSize: 15.sp,
              ),
              titleTextStyle: TextStyle(color: Colors.black),
              backgroundColor: Colors.white,
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormWidget(
                      context: context,
                      textEditingController: name,
                      labelText: AppLocalizations.of(context)!.name,
                      focusNode: FocusNode(),
                      validationMethod: (text) => widget.nameValidator(text),
                    ),
                    TextFormWidget(
                      context: context,
                      textEditingController: email,
                      labelText: AppLocalizations.of(context)!.email,
                      focusNode: FocusNode(),
                      validationMethod: (text) => widget.emailValidator(text),
                    ),
                    AddressFormWidget(
                      context: context,
                      textEditingController: address,
                      labelText: "Address",
                      focusNode: FocusNode(),
                      validationMethod: (text) => widget.addressValidator(text),
                    ),
                    ContactFormWidget(
                      context: context,
                      textEditingController: firstPhoneNumber,
                      labelText: AppLocalizations.of(context)!.contactNo,
                      bottomText: "CONTACT NUMBER SHOULD BE LIKE (0966)",
                      initialValue: "0966",
                      focusNode: FocusNode(),
                      validationMethod: (text) =>
                          widget.contactNoValidator(text),
                    ),
                    ContactFormWidget(
                      context: context,
                      textEditingController: secondPhoneNumber,
                      labelText: AppLocalizations.of(context)!.contactNo,
                      bottomText: "CONTACT NUMBER SHOULD BE LIKE (0966)",
                      initialValue: "0966",
                      focusNode: FocusNode(),
                      validationMethod: (text) =>
                          widget.contactNoValidator(text),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Center(
                      child: CustomText(
                        text: "Payment Method",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                          start: 20, top: 20, bottom: 20),
                      child: RadioGroup<String>.builder(
                        groupValue: _verticalGroupValue,
                        onChanged: (value) => setState(() {
                          _verticalGroupValue = value!;
                        }),
                        items: _status,
                        itemBuilder: (item) => RadioButtonBuilder(
                          item,
                        ),
                        activeColor: Theme.of(context).primaryColor,
                      ),
                    ),
                    if (_verticalGroupValue == _status[2])
                      Container(
                        height: 100,
                        child: Column(
                          children: [
                            CustomText(
                              text: "Select Branch",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 40,
                              margin: EdgeInsetsDirectional.all(10),
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 20,
                                  itemBuilder: (context, index) {
                                    return branchCard(
                                        "Index " + index.toString());
                                  }),
                            )
                          ],
                        ),
                      ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).primaryColor)),
                      height: 150,
                      width: 90.w,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextFormField(
                          maxLines: 7,
                          style: TextStyle(
                              fontSize: 14.sp, letterSpacing: 1.0, height: 1.5),
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration.collapsed(
                            hintText: "Note",
                            hintStyle: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 14.sp),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    CustomButton(
                      padding: EdgeInsets.all(2.w),
                      buttonColor: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      text: "Proceed",
                      size: Size(double.infinity, 50),
                      textFontSize: 12.sp,
                      onTap: () => onPlaceOrderPressed(),
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
    ));
  }

  Widget branchCard(String? text) {
    bool branchSelect = text == selectedBranch;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedBranch = text!;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            width: 1,
            color:
                branchSelect ? Theme.of(context).primaryColor : Colors.black12,
          ),
        ),
        margin: const EdgeInsetsDirectional.only(start: 10),
        child: Center(
          child: CustomText(
            text: text,
            fontSize: 12.sp,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Future<void> onPlaceOrderPressed() async {
    if (_placeOrderFormKey.currentState!.validate()) {
      print("Validated");
    }
  }
}
