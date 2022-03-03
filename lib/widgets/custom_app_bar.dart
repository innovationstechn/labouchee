import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'custom_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;

  CustomAppBar({
    this.title = 'Title',
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
        toolbarHeight: 50,
        elevation: 0,
        leading: const BackButton(
            color: Colors.black
        ),
        title: CustomText(
          text: title, fontWeight: FontWeight.bold, fontSize: 15.sp,),
        titleTextStyle: const TextStyle(color: Colors.black),
        backgroundColor: Colors.white);
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

}
