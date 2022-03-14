import 'package:flutter/material.dart';
import 'package:labouchee/models/my_order.dart';
import 'package:labouchee/pages/my_order_detail/my_order_detail_viewmodel.dart';
import 'package:labouchee/widgets/custom_app_bar.dart';
import 'package:labouchee/widgets/my_order_details_widgets/order_product_details.dart';
import 'package:labouchee/widgets/my_order_details_widgets/user_detail.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked/stacked.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../widgets/custom_circular_progress_indicator.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/my_order_details_widgets/order_info.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.orderDetails,
      ),
      body: ViewModelBuilder<MyOrderDetailVM>.reactive(
        viewModelBuilder: () => MyOrderDetailVM(order: widget.order),
        onModelReady: (model) => model.loadData(),
        builder: (context, detailVM, _) {
          return LayoutBuilder(builder: (context, BoxConstraints constraints) {
            boxConstraints = constraints;

            if (detailVM.isBusy) {
              return Center(child: CustomCircularProgressIndicator());
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  CustomText(
                    text: AppLocalizations.of(context)!.myOrder,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  UserDetail(
                    detailModel: detailVM.detail!,
                  ),
                  OrderInfo(
                    detailModel: detailVM.detail!,
                  ),
                  MyOrderProductDetails(detailModel: detailVM.detail!),
                  customRow(AppLocalizations.of(context)!.deliveryCharges,
                      detailVM.detail!.shippingAmount.toString(),11.sp),
                  customRow(AppLocalizations.of(context)!.discountAmount,
                      detailVM.detail!.discountAmount.toString(),11.sp),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: DottedBorder(
                      color: Colors.brown.shade400,
                      strokeWidth: 1,
                      child: customRow(
                          AppLocalizations.of(context)!.grandTotal,
                          detailVM.detail!.orderTotalAmount.toString() +  " " +
                              AppLocalizations.of(context)!.currency,
                        13.sp
                      ),
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

  Widget customRow(String title, String value,double fontSize) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
          start: 10, end: 20, top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: title,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
          CustomText(text: value, fontSize: fontSize),
        ],
      ),
    );
  }
}
