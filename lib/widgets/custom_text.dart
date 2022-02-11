import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? padding;
  final Function? onTap;

  const CustomText(
      {Key? key,
      this.text,
      this.color,
      this.fontSize,
      this.fontWeight,
      this.onTap,
      this.padding = EdgeInsets.zero})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding!,
      child: GestureDetector(
        onTap:(){
          if(onTap!=null) {
            onTap!();
          }
        },
        child: Text(
          text!,
          style:
              TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color),
        ),
      ),
    );
  }
}
