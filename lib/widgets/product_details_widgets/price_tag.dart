import 'package:flutter/cupertino.dart';
import 'package:labouchee/pages/product_details/product_details_viewmodel.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../custom_text.dart';

class PriceTag extends StatelessWidget {
  final ProductDetailsVM productDetailsVM;
  final String selectedSize;

  const PriceTag(
      {Key? key, required this.productDetailsVM, required this.selectedSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: priceSelection().toString() + " " + AppLocalizations.of(context)!.currency,
      fontSize: 14.sp,
      fontWeight: FontWeight.bold,
    );
  }

  double? priceSelection(){
     double? price;

     if (productDetailsVM.details.price != null) {
       price = productDetailsVM.details.price!;
     } else {
       switch (selectedSize) {
         case 'SMALL':
           price = productDetailsVM.details.priceSmall!;
           break;
         case 'MEDIUM':
           price = productDetailsVM.details.priceMedium!;
           break;
         case 'LARGE':
           price = productDetailsVM.details.priceLarge!;
           break;
       }
     }
     return price??0;
  }

}
