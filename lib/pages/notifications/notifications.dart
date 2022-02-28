import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labouchee/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class Notifications extends StatelessWidget {
  Notifications({Key? key}) : super(key: key);
  final List<String> text = [
    "You have place an order.Your order is under review",
    "You have place an order.Your order is under review",
    "You have place an order.Your order is under review"
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return notificationCard(index);
          },
          itemCount: 3),
    );
  }

  Widget notificationCard(int? index) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: text[index!],
                  maxLines: 10,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 10,),
                CustomText(text: "Created at ....",fontSize: 10.sp,color: Colors.black,fontWeight: FontWeight.normal,),
              ],
            ),
          ),
          const Divider(color: Colors.grey,)
        ],
      ),
    );
  }
}
