import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labouchee/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomButton extends StatelessWidget {
  final double? textFontSize;
  final Color? textColor;
  final String? text;
  final Color? buttonColor;
  final Size? size;
  final Function onTap;
  final double? circularSize;
  final EdgeInsetsGeometry? padding;
  const CustomButton(
      {Key? key,
      this.textFontSize,
      this.textColor,
      this.buttonColor,
      this.padding,
      this.size,
      this.circularSize,
      required this.onTap,
      this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(circularSize ?? 0.0),
            ),
            primary: buttonColor ?? Theme.of(context).primaryColor,
            minimumSize: size,
            maximumSize: size,
          ),
          child: CustomText(
            text: text,
            fontSize: textFontSize,
            color: textColor,
          ),
          onPressed: () => onTap()),
    );
  }
}
