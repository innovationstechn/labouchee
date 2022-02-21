import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'custom_text.dart';

class ProductSize extends StatefulWidget {
  final Function? onTap;
  const ProductSize({Key? key,this.onTap}) : super(key: key);

  @override
  _ProductSizeState createState() => _ProductSizeState();
}

class _ProductSizeState extends State<ProductSize> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          margin: EdgeInsetsDirectional.only(start: 10),
          color: Theme.of(context).primaryColor,
          width: constraints.maxWidth * 0.1,
          height: constraints.maxWidth * 0.1,
          child: Center(
            child: CustomText(text: "S", fontSize: 14.sp,color: Colors.white,),
          ),
        );
      }
    );
  }
}
