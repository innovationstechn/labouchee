import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../models/my_order_detail.dart';
import '../custom_text.dart';

class UserDetail extends StatefulWidget {
  final MyOrderDetailModel detailModel;
  const UserDetail(
      {Key? key,
      required this.detailModel})
      : super(key: key);

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  late BoxConstraints boxConstraints;
  @override
  Widget build(BuildContext context) {
    final MyOrderUserInputDetailModel myOrderUserInputDetailModel = widget.detailModel.orderDetails!;
    return LayoutBuilder(
      builder: (context,constraints) {
        boxConstraints = constraints;
        return Card(
          elevation: 0,
          margin: const EdgeInsets.symmetric(horizontal:10,vertical: 10),
          color: Colors.grey.shade100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              userInfoTile(Icons.account_circle_rounded, AppLocalizations.of(context)!.name, myOrderUserInputDetailModel.name!),
              userInfoTile(Icons.phone, AppLocalizations.of(context)!.contactNo, myOrderUserInputDetailModel.phone.toString()),
              userInfoTile(Icons.message, AppLocalizations.of(context)!.email, myOrderUserInputDetailModel.email!),
              userInfoTile(Icons.location_city, AppLocalizations.of(context)!.address+ ":",
                  myOrderUserInputDetailModel.address!.first),
            ],
          ),
        );
      }
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
                    radius: 12,
                    backgroundColor: Colors.brown.shade200,
                    child: Icon(
                      icon,
                      size: 14,
                      color: Colors.white,
                    )),
                Container(
                  width: boxConstraints.maxWidth * 0.25,
                  child: CustomText(
                    padding: EdgeInsetsDirectional.only(start: 10),
                    text: title,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    maxLines: 3,
                  ),
                ),
              ],
            ),
          ),
          Container(
              width: boxConstraints.maxWidth * 0.6 - 30,
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
}
