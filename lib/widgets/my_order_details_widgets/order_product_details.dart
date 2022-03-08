import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:labouchee/models/cart_item.dart';
import 'package:labouchee/models/my_order_detail.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../custom_text.dart';

class MyOrderProductDetails extends StatefulWidget {
  final MyOrderDetailModel detailModel;

  const MyOrderProductDetails(
      {Key? key,required this.detailModel})
      : super(key: key);

  @override
  State<MyOrderProductDetails> createState() => _MyOrderProductDetailsState();
}

class _MyOrderProductDetailsState extends State<MyOrderProductDetails> {
  late BoxConstraints boxConstraints;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints) {
        boxConstraints = constraints;
        return Column(
          children: [
            Center(
              child: CustomText(
                text: AppLocalizations.of(context)!.orderDetails,
                fontSize: 18.sp,
                maxLines: 2,
                fontWeight: FontWeight.w600,
                underline: true,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Wrap(
              children: [
                ...widget.detailModel.orderItems!.map((item) =>
                    productDetailCard(item))
              ],
            )
          ],
        );
      }
    );
  }

  Widget productDetailCard(CartItemModel cartItemModel) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4,horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: boxConstraints.maxWidth * 0.25,
            height:boxConstraints.maxWidth * 0.28,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              child: SizedBox.expand(
                  child: Image.network(
                      cartItemModel.image!,
                      fit:BoxFit.fill
              )),
            ),
          ),
          Column(
            children: [
              productInfoTile(AppLocalizations.of(context)!.product, cartItemModel.title!),
              productInfoTile(
                  AppLocalizations.of(context)!.unitPrice, cartItemModel.size![0].price.toString()),
              productInfoTile(AppLocalizations.of(context)!.size, cartItemModel.size![0].type!),
              productInfoTile(
                  AppLocalizations.of(context)!.quantity, cartItemModel.totalQuantity.toString()),
              productInfoTile(
                  AppLocalizations.of(context)!.totalAmount, cartItemModel.totalAmount.toString()+ " "+ AppLocalizations.of(context)!.currency),
            ],
          )
        ],
      ),
    );
  }

  Widget productInfoTile(String title, String value) {
    return Container(
      width: boxConstraints.maxWidth * 0.7-20,
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
