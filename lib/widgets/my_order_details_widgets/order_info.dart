import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../models/my_order_detail.dart';
import '../custom_text.dart';

class OrderInfo extends StatelessWidget {
  final MyOrderDetailModel detailModel;
  const OrderInfo({Key? key, required this.detailModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Center(
            child: CustomText(
              text: AppLocalizations.of(context)?.orderInfo,
              fontSize: 18.sp,
              maxLines: 2,
              fontWeight: FontWeight.bold,
              underline: true,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          orderInfoTile(AppLocalizations.of(context)!.orderDate,
              detailModel.createdTime ?? ""),
          orderInfoTile(AppLocalizations.of(context)!.bookingDate,
              detailModel.orderDetails?.bookingDate ?? ""),
          orderInfoTile(AppLocalizations.of(context)!.bookingTime,
              detailModel.orderDetails?.bookingTime ?? ""),
          orderInfoTile(AppLocalizations.of(context)!.paymentMethod,
              detailModel.paymentMethod!),
          orderInfoTile(AppLocalizations.of(context)!.paymentStatus,
              detailModel.paymentStatus!),
          orderInfoTile(AppLocalizations.of(context)!.note,
              detailModel.orderDetails!.orderNote ?? ""),
          Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Divider(
                // height: 2,
                thickness: 1,
                color: Theme.of(context).primaryColor,
              ))
        ],
      ),
    );
  }

  Widget orderInfoTile(String title, String value) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
}
