import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_text.dart';

class Branches extends StatelessWidget {
  const Branches({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: CustomAppBar(title: 'Branches'),
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: branchCard(),
            );
          }),
    ));
  }

  Widget branchCard() {
    return Card(
      color: Colors.white54,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.home,
                  size: 17.sp,
                ),
                SizedBox(
                  width: 10,
                ),
                CustomText(text: 'HOME', fontSize: 12.sp),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.phone,
                  size: 17.sp,
                ),
                SizedBox(
                  width: 10,
                ),
                CustomText(text: 'Settings', fontSize: 12.sp),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.phone,
                  size: 17.sp,
                ),
                SizedBox(
                  width: 10,
                ),
                CustomText(text: 'Settings', fontSize: 12.sp),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.watch_later_outlined,
                  size: 17.sp,
                ),
                SizedBox(
                  width: 10,
                ),
                CustomText(text: 'Settings', fontSize: 12.sp),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.email,
                  size: 17.sp,
                ),
                SizedBox(
                  width: 10,
                ),
                CustomText(text: 'Settings', fontSize: 12.sp),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.pin_drop,
                  size: 17.sp,
                ),
                SizedBox(
                  width: 10,
                ),
                CustomText(text: 'Settings', fontSize: 12.sp),
              ],
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
