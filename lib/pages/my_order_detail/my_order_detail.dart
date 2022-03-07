import 'package:flutter/material.dart';
import 'package:labouchee/models/my_order.dart';
import 'package:labouchee/pages/my_order_detail/my_order_detail_viewmodel.dart';
import 'package:labouchee/widgets/custom_app_bar.dart';
import 'package:labouchee/widgets/my_order_details_widgets/order_product_details.dart';
import 'package:labouchee/widgets/my_order_details_widgets/user_detail.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked/stacked.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/my_order_details_widgets/order_info.dart';

class MyOrderDetailPage extends StatefulWidget {
  final MyOrderModel order;

  const MyOrderDetailPage({Key? key, required this.order}) : super(key: key);

  @override
  State<MyOrderDetailPage> createState() => _MyOrderDetailPageState();
}

class _MyOrderDetailPageState extends State<MyOrderDetailPage> {
  late BoxConstraints boxConstraints;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Order Details",),
      body: ViewModelBuilder<MyOrderDetailVM>.reactive(
        viewModelBuilder: () => MyOrderDetailVM(order: widget.order),
        onModelReady: (model) => model.loadData(),
        builder: (context, detailVM, _) {
          return LayoutBuilder(
              builder: (context, BoxConstraints constraints) {
            boxConstraints = constraints;

            if(detailVM.isBusy) {
              return Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  CustomText(
                    text: "My Order",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  UserDetail(
                      detailModel: detailVM.detail!,),
                  OrderInfo(detailModel: detailVM.detail!,),
                  MyOrderProductDetails(detailModel: detailVM.detail!),
                  customRow("Delivery Charges", detailVM.detail!.shippingAmount.toString()),
                  customRow("Discount Amount", detailVM.detail!.discountAmount.toString()),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: DottedBorder(
                      color: Colors.brown.shade400,
                      strokeWidth: 1,
                      child: customRow("Grand Total", detailVM.detail!.orderTotalAmount.toString()),
                    ),
                  )
                ],
              ),
            );
          });
        },
      ),
    );
  }

  Widget customRow(String title,String value){
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 10,end:20,top: 10,bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text: title,fontSize: 15.sp,fontWeight: FontWeight.bold,),
          CustomText(text: value,fontSize: 13.sp),
        ],
      ),
    );
  }
}