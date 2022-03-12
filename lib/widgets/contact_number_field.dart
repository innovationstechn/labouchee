import 'package:flutter/material.dart';
import 'package:labouchee/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class ContactFormWidget extends FormField<String> {
  final String? labelText, bottomText;
  final BuildContext? context;
  final FocusNode? focusNode;
  final TextEditingController? textEditingController;
  final Function(String?) validationMethod;
  final String? errorText;
  final bool autofocus;

  ContactFormWidget(
      {Key? key,
      this.context,
      this.textEditingController,
      this.labelText,
      this.focusNode,
      this.bottomText = "",
      this.errorText,
      this.autofocus = true,
      required this.validationMethod,
      String initialValue = "",
      AutovalidateMode autoValidate = AutovalidateMode.disabled})
      : super(
            key: key,
            initialValue: initialValue,
            autovalidateMode: autoValidate,
            builder: (FormFieldState<String> state) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context!).primaryColor)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 8.0, left: 8, right: 8),
                        child: InternationalPhoneNumberInput(
                          selectorConfig: const SelectorConfig(
                            selectorType: PhoneInputSelectorType.DROPDOWN,
                            showFlags: true,
                          ),
                          countries: ["SA"],
                          validator: (String? text) {
                            String? isValidationFailed = validationMethod(text);
                            if (isValidationFailed != null) {
                              return isValidationFailed;
                            }
                          },
                          autoFocus: autofocus,
                          textStyle:
                              TextStyle(color: Colors.black, fontSize: 13.sp),
                          inputDecoration: InputDecoration(
                            errorText: errorText,
                            hintText: labelText,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor),
                            ),
                            hintStyle: TextStyle(
                                color: focusNode!.hasFocus
                                    ? Colors.black
                                    : Theme.of(context).primaryColor,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w300),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 1.0,
                              ),
                            ),
                          ),
                          textFieldController: textEditingController,
                          onInputChanged: (PhoneNumber value) {
                            state.didChange(textEditingController!.text);
                          },
                          keyboardType: TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                        ),
                      ),
                    ),
                    if (bottomText != "")
                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 1.w, vertical: 10),
                          child: CustomText(
                              text: bottomText,
                              fontSize: 8.sp,
                              fontWeight: FontWeight.w300,
                              color: Colors.black),
                        ),
                      ),
                  ],
                ),
              );
            });
}
