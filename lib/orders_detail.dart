import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:labouchee/product_card.dart';
import 'package:labouchee/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  late BoxConstraints boxConstraints;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
      boxConstraints = constraints;
      return SingleChildScrollView(
        child: Column(
          children: [
            CustomText(text: "My Order",fontSize: 18.sp,fontWeight: FontWeight.bold,),
            buildUserDetailWidget(),
            buildOrderInfoWidget(),
            buildProductDisplayCard()
          ],
        ),
      );
    });
  }

  Widget buildProductDisplayCard() {
    return Column(
      children: [
        Center(
          child: CustomText(
            text: "Order Details",
            fontSize: 18.sp,
            maxLines: 2,
            fontWeight: FontWeight.w600,
            underline: true,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        productDetailCard(),
        productDetailCard(),
        productDetailCard(),
      ],
    );
  }

  Widget buildOrderInfoWidget() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Center(
            child: CustomText(
              text: "Order Info",
              fontSize: 18.sp,
              maxLines: 2,
              fontWeight: FontWeight.bold,
              underline: true,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          orderInfoTile("Order Date", "asdasd"),
          orderInfoTile("Payment Method", "asdasd"),
          orderInfoTile("Payment Status", "asdasd"),
          orderInfoTile("Delivery Date", "asdasd"),
          orderInfoTile("Delivery Time", "asdasd"),
          orderInfoTile("Note", "asdasd"),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Divider(
                height: 2,
                thickness: 1,
                color: Theme.of(context).primaryColor,
              ))
        ],
      ),
    );
  }

  Widget buildUserDetailWidget() {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      color: Colors.grey.shade300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          userInfoTile(Icons.info, "Name", "Umer App View"),
          userInfoTile(Icons.info, "Mobile No:", "Umer App View"),
          userInfoTile(Icons.info, "Email", "Umer App View"),
          userInfoTile(Icons.info, "City", "Umer App View"),
          userInfoTile(Icons.info, "Postal Code:", "Umer App View"),
          userInfoTile(Icons.info, "Address:",
              "Umer App Viewadssssssssssssssssssssssssssssssssssssssssssssssssssssssssss"),
        ],
      ),
    );
  }

  Widget userInfoTile(IconData icon, String title, String value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            width: boxConstraints.maxWidth * 0.4,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                    radius: 17,
                    backgroundColor: Color(0xff94d500),
                    child: Icon(
                      icon,
                      size: 18,
                      color: Colors.black,
                    )),
                Container(
                  width: boxConstraints.maxWidth * 0.25,
                  child: CustomText(
                    padding: EdgeInsetsDirectional.only(start: 10),
                    text: title,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    maxLines: 3,
                  ),
                ),
              ],
            ),
          ),
          Container(
              width: boxConstraints.maxWidth * 0.6 - 20,
              child: CustomText(
                padding: EdgeInsetsDirectional.only(start: 10),
                text: value,
                fontSize: 12.sp,
                maxLines: 2,
              )),
        ],
      ),
    );
  }

  Widget orderInfoTile(String title, String value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            padding: EdgeInsetsDirectional.only(start: 10),
            text: title,
            fontSize: 12.sp,
            maxLines: 2,
            fontWeight: FontWeight.bold,
          ),
          CustomText(
            padding: EdgeInsetsDirectional.only(start: 10),
            text: value,
            fontSize: 12.sp,
            maxLines: 2,
          )
        ],
      ),
    );
  }

  Widget productDetailCard() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: boxConstraints.maxWidth * 0.25,
            height: boxConstraints.maxWidth * 0.28,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              child: SizedBox.expand(child: FlutterLogo()),
            ),
          ),
          Column(
            children: [
              productInfoTile("Prouduct", "Cheese Cake"),
              productInfoTile("Prouduct", "Cheese Cake"),
              productInfoTile("Prouduct", "Cheese Cake"),
              productInfoTile("Prouduct", "Cheese Cake"),
              productInfoTile("Prouduct", "Cheese Cake"),
            ],
          )
        ],
      ),
    );
  }

  Widget productInfoTile(String title, String value) {
    return Container(
      width: boxConstraints.maxWidth * 0.7,
      margin: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            padding: EdgeInsetsDirectional.only(start: 10),
            text: title,
            fontSize: 10.sp,
            maxLines: 2,
            fontWeight: FontWeight.bold,
          ),
          CustomText(
            padding: EdgeInsetsDirectional.only(start: 10),
            text: value,
            fontSize: 10.sp,
            maxLines: 2,
          )
        ],
      ),
    );
  }
}
