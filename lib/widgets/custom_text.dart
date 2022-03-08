import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class CustomText extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? padding;
  final Function? onTap;
  final int? maxLines;
  final bool underline;

  const CustomText(
      {Key? key,
      this.text,
      this.color,
      this.fontSize,
      this.fontWeight,
      this.onTap,
      this.maxLines,
      this.underline = false,
      this.padding = EdgeInsets.zero})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding!,
      child: onTap == null
          ? Text(
              text!,
              maxLines: maxLines,
              style: TextStyle(
                  decoration: underline?TextDecoration.underline:null,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  color: color,
                  overflow: TextOverflow.ellipsis),
            )
          : GestureDetector(
              onTap: () {
                if (onTap != null) {
                  onTap!();
                }
              },
              child: Text(
                text!,
                maxLines: maxLines,
                style: TextStyle(
                    decoration: underline?TextDecoration.underline:null,
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    color: color,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
    );
  }
}
