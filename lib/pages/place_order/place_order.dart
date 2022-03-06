import 'dart:math';
import 'package:flutter/material.dart';
import 'package:labouchee/models/place_order.dart';
import 'package:labouchee/models/register_error_model.dart';
import 'package:labouchee/pages/place_order/place_order_viewmodel.dart';
import 'package:labouchee/pages/register/register_viewmodel.dart';
import 'package:labouchee/widgets/address_field.dart';
import 'package:labouchee/widgets/booking_date_time_ui.dart';
import 'package:labouchee/widgets/contact_number_field.dart';
import 'package:stacked/stacked.dart';
import 'package:labouchee/mixins/validator_mixin.dart';
import 'package:labouchee/widgets/custom_button.dart';
import 'package:labouchee/widgets/custom_text.dart';
import 'package:labouchee/widgets/custom_text_form_field.dart';
import 'package:sizer/sizer.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../models/place_order_error.dart';

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

  String selectedDate = "";
  String selectedTime = "";
  int selectedBranch = 0;
  int selectedCity = -1;

  final TextEditingController email = TextEditingController(),
      name = TextEditingController(),
      address = TextEditingController(),
      firstPhoneNumber = TextEditingController(),
      secondPhoneNumber = TextEditingController(),
      notes = TextEditingController();

  PlaceOrderErrorModel placeOrderValidationErrorModel = PlaceOrderErrorModel(
      name: null,
      email: null,
      phone: null,
      city: null,
      paymentMethod: null,
      branch: null,
      notes: null,
      bookingDate: null,
      bookingTime: null);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PlaceOrderVM>.reactive(
      onModelReady: (model) => model.initialize(),
      viewModelBuilder: () => PlaceOrderVM(),
      builder: (context, placeOrderVM, _) {
        if (placeOrderVM.isBusy) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Form(
          key: _placeOrderFormKey,
          child: Scaffold(
            body: Center(
              child: CustomScrollView(slivers: [
                SliverAppBar(
                  leading: const BackButton(color: Colors.black),
                  title: CustomText(
                    text: "Place Order",
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                  ),
                  titleTextStyle: const TextStyle(color: Colors.black),
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
                          validationMethod: (text) =>
                              widget.nameValidator(text),
                        ),
                        TextFormWidget(
                          context: context,
                          textEditingController: email,
                          labelText: AppLocalizations.of(context)!.email,
                          focusNode: FocusNode(),
                          errorText:
                              placeOrderValidationErrorModel.email != null
                                  ? placeOrderValidationErrorModel.email!.first
                                  : null,
                          validationMethod: (text) =>
                              widget.emailValidator(text),
                        ),
                        cityWidget(),
                        AddressFormWidget(
                          context: context,
                          textEditingController: address,
                          labelText: "Address",
                          errorText: placeOrderValidationErrorModel.address !=
                                  null
                              ? placeOrderValidationErrorModel.address!.first
                              : null,
                          focusNode: FocusNode(),
                          validationMethod: (text) =>
                              widget.addressValidator(text),
                        ),
                        ContactFormWidget(
                          context: context,
                          textEditingController: firstPhoneNumber,
                          labelText: AppLocalizations.of(context)!.contactNo,
                          bottomText: "CONTACT NUMBER SHOULD BE LIKE (0966)",
                          initialValue: "0966",
                          errorText:
                              placeOrderValidationErrorModel.phone != null
                                  ? placeOrderValidationErrorModel.phone!.first
                                  : null,
                          focusNode: FocusNode(),
                          validationMethod: (text) =>
                              widget.contactNoValidator(text),
                        ),
                        BookingDateAndTime(
                            selectDate:()=> _selectDate(context, placeOrderVM),
                            selectTime: ()=> _selectBookingTime(context, placeOrderVM),
                            selectedDate: selectedDate,
                            selectedTime: selectedTime,
                            placeOrderValidationErrorModel: placeOrderValidationErrorModel),
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
                          SizedBox(
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
                                  margin: const EdgeInsetsDirectional.all(10),
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: placeOrderVM.branches.length,
                                    itemBuilder: (context, index) {
                                      return branchCard(
                                        placeOrderVM.branches[index].name!,
                                        placeOrderVM.branches[index].id,
                                      );
                                    },
                                  ),
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
                              controller: notes,
                              maxLines: 7,
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  letterSpacing: 1.0,
                                  height: 1.5),
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
                          size: const Size(double.infinity, 50),
                          textFontSize: 12.sp,
                          onTap: () => onPlaceOrderPressed(placeOrderVM),
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

  Widget branchCard(String? text, int branchID) {
    bool branchSelect = branchID == selectedBranch;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedBranch = branchID;
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


  Widget cityWidget(){
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(horizontal: 14,vertical: 2.w),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
            color: Theme.of(context).primaryColor),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          elevation: 0,
          hint: CustomText(
              text: "Select City",
              color: Theme.of(context).primaryColor,
              fontSize: 13.sp,
              fontWeight: FontWeight.w300),
          items: <String>['A', 'B', 'C', 'D']
              .map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: CustomText(
                text: value,
              ),
            );
          }).toList(),
          onChanged: (_) {},
        ),
      ),
    );
  }

  Future _selectDate(
      BuildContext context, PlaceOrderVM placeOrderVM) async {
    final now = DateTime.now();
    String formatter = DateFormat('yMd').format(now);
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: now,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null) {
      selectedDate = DateFormat('yyyy-MM-dd').format(picked);
      placeOrderVM.notifyListeners();
    }
  }

  Future _selectBookingTime(
      BuildContext context, PlaceOrderVM placeOrderVM) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.dial,
        confirmText: "CONFIRM",
        cancelText: "NOT NOW",
        helpText: "BOOKING TIME");
    if (timeOfDay != null) {
      selectedTime = timeOfDay.format(context).toString();
      placeOrderVM.notifyListeners();
    }
  }

  Future<void> onPlaceOrderPressed(PlaceOrderVM placeOrderVM) async {
    if (_placeOrderFormKey.currentState!.validate()) {
      switch (_verticalGroupValue) {
        case "Credit or debit card/paypal":
          await placeOrderVM.placeOrder(
            name.text,
            firstPhoneNumber.text,
            1,
            email.text,
            PaymentMethod.digital,
            selectedBranch,
            address.text,
            address.text,
            selectedDate,
            selectedTime,
            "NO NOTES",
          );
          break;
        case "Cash on Delivery":
          await placeOrderVM.placeOrder(
            name.text,
            firstPhoneNumber.text,
            1,
            email.text,
            PaymentMethod.cashOnDelivery,
            null,
            address.text,
            "Address2",
            selectedDate,
            selectedTime,
            notes.text,
          );
          break;
        case "Pick from Branch":
          if (selectedBranch != 0) {
            await placeOrderVM.placeOrder(
              name.text,
              firstPhoneNumber.text,
              1,
              email.text,
              PaymentMethod.pickup,
              selectedBranch,
              address.text,
              "Address2",
              selectedDate,
              selectedTime,
              notes.text,
            );
          }
          break;
      }

      if (placeOrderVM.hasError) {
        placeOrderValidationErrorModel =
            placeOrderVM.error(placeOrderVM) as PlaceOrderErrorModel;
        placeOrderVM.notifyListeners();
      } else {
        // registerVM.navigateToOTPVerification();
      }
    }
  }
}
