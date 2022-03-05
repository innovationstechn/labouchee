import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labouchee/pages/my_orders/my_orders_vm.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked/stacked.dart';

import '../../models/my_order.dart';
import '../../widgets/custom_text.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyOrdersVM>.reactive(
        viewModelBuilder: () => MyOrdersVM(),
        onModelReady: (model)=> model.loadData(),
        builder: (context, ordersVM, _) {

          if(ordersVM.isBusy) {
            return Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),);
          }

          return ListView.builder(
              itemCount: ordersVM.orders.length,
              itemBuilder: (context, index) {
                return orderCard(ordersVM.orders[index]);
              });
        });
  }

  Widget orderCard(MyOrderModel myOrderModel) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Theme.of(context).primaryColor, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomText(
                      text: "Name: ",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      text: myOrderModel.orderDetails,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ],
                ),
                CustomText(
                  text: myOrderModel.createdTime,
                  fontSize: 12.sp,
                  color: Colors.brown,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomText(
                      text: "OrderID: ",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      text: myOrderModel.id.toString(),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ],
                ),
                Row(
                  children: [
                    CustomText(
                      text: "Total amount:",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      text: myOrderModel.orderAmount.toString(),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0))),
                  ),
                  onPressed: () async {},
                  child: CustomText(
                    text: "Details",
                    color: Colors.brown,
                    fontSize: 12.sp,
                  ),
                ),
                CustomText(
                  text: "Status: "+myOrderModel.status!,
                  fontSize: 12.sp,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
