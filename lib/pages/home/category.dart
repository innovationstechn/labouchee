import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/custom_text.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<String> items = [
    "HELLO",
    "easdsa",
    "SDASDA",
    "SASDASDAS",
    "ASDADASDAS",
    "ASDASDSAD",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(text: "Category",fontWeight: FontWeight.bold,fontSize:14.sp,),
              CustomText(
                  text: "View All",
                  color: Theme.of(context).primaryColor,
                  onTap: () {}),
            ],
          ),
        ),
        SizedBox(
          height: 30.h,
          child: Padding(
              padding: EdgeInsets.all(1.w),
              child: Wrap(
                direction: Axis.horizontal,
                children: [
                  ...items.map((item) => Container(
                      height: 15.h, width: 32.w, child: categoryCard()))
                ],
              )),
        ),
      ],
    );
  }

  Widget categoryCard() {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Icon(
            Icons.access_time_outlined,
            size: 9.h,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "Product Name",
            overflow: TextOverflow.fade,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.normal,
            ),
          )
        ],
      ),
    );
  }
}
