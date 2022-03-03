import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labouchee/widgets/custom_app_bar.dart';
import 'package:sizer/sizer.dart';

class CategoriesListing extends StatefulWidget {
  const CategoriesListing({Key? key}) : super(key: key);

  @override
  _CategoriesListingState createState() => _CategoriesListingState();
}

class _CategoriesListingState extends State<CategoriesListing> {

  List<String> items = [
    "HELLO",
    "easdsa",
    "SDASDA",
    "SASDASDAS",
    "ASDADASDAS",
    "ASDASDSAD",
    "ASDASDSAD",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title:"Categories"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(1.w),
          child: Wrap(
            direction: Axis.horizontal,
            children: [
              ...items.map((item) =>
                  Container(height: 15.h, width: 32.w, child: categoryCard()))
            ],
          ),
        ),
      ),
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
