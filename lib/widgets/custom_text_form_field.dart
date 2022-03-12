import 'package:flutter/material.dart';
import 'package:labouchee/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TextFormWidget extends FormField<String> {
  final String? labelText;
  final IconData? suffixIcon;
  final bool? showIcon;
  final BuildContext? context;
  final FocusNode? focusNode;
  final TextEditingController? textEditingController;
  final Function(String?) validationMethod;
  final String? errorText;
  final bool isReadOnly;
  final bool autofocus;

  TextFormWidget(
      {Key? key,
      this.context,
      this.textEditingController,
      this.showIcon = false,
      this.labelText,
      this.suffixIcon,
      this.focusNode,
      this.errorText,
      this.autofocus = true,
      bool? obscureText = false,
      this.isReadOnly = false,
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
                    TextFormField(
                      readOnly: isReadOnly,
                      enableSuggestions: true,
                      obscureText: obscureText!,
                      controller: textEditingController,
                      onChanged: (String? text) {
                        state.didChange(textEditingController!.text);
                      },
                      validator: (String? text) {
                        String? isValidationFailed = validationMethod(text);
                        if (isValidationFailed != null) {
                          return isValidationFailed;
                        }
                      },
                      autofocus: autofocus,
                      style: TextStyle(color: Colors.black, fontSize: 13.sp),
                      decoration: InputDecoration(
                        errorText: errorText,
                        // hintText: hintText,
                        labelText: labelText,
                        labelStyle: TextStyle(
                            color: focusNode!.hasFocus
                                ? Colors.black
                                : Theme.of(context!).primaryColor,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w300),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Theme.of(context!).primaryColor,
                            width: 1.0,
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            showIcon == true
                                ? obscureText == false
                                    ? Icons.visibility
                                    : Icons.visibility_off
                                : null,
                            color: Theme.of(context).primaryColor,
                          ),
                          onPressed: () {
                            obscureText = !obscureText!;
                            state.didChange(state.value);
                          },
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
}
