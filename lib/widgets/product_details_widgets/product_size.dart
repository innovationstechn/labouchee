import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../pages/product_details/product_details_viewmodel.dart';
import '../custom_text.dart';
import 'package:flutter/cupertino.dart';

class ProductSize extends StatefulWidget {
  final Function onSizeChanged;
  final String selectedSize;
  final ProductDetailsVM productDetailsVM;

  const ProductSize(
      {Key? key,
      required this.onSizeChanged,
      required this.selectedSize,
      required this.productDetailsVM})
      : super(key: key);

  @override
  State<ProductSize> createState() => _ProductSizeState();
}

class _ProductSizeState extends State<ProductSize> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          margin: const EdgeInsetsDirectional.only(bottom: 20, top: 10),
          child: productSizeWidget(constraints, widget.productDetailsVM),
        );
      },
    );
  }

  Widget productSizeWidget(
      BoxConstraints constraints, ProductDetailsVM productDetailsVM) {
    if (productDetailsVM.details.price != null) {
      String? size = "STANDARD";
      String? sizeTranslation = AppLocalizations.of(context)?.standard;
      if (productDetailsVM.details.priceSmall != null) {
        size = 'SMALL';
        sizeTranslation = AppLocalizations.of(context)?.small;
      }
      if (productDetailsVM.details.priceMedium != null) {
        size = 'MEDIUM';
        sizeTranslation = AppLocalizations.of(context)?.medium;
      }
      if (productDetailsVM.details.priceLarge != null) {
        size = 'LARGE';
        sizeTranslation = AppLocalizations.of(context)?.large;
      }

      return Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            CustomText(
              text: AppLocalizations.of(context)?.availableSize,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
            CustomText(
              text: sizeTranslation,
              fontSize: 12.sp,
              fontWeight: FontWeight.normal,
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: AppLocalizations.of(context)?.availableSizes,
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
          padding: const EdgeInsets.symmetric(vertical: 20),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (productDetailsVM.details.priceSmall != null)
              productSize(constraints, "SMALL"),
            if (productDetailsVM.details.priceMedium != null)
              productSize(constraints, "MEDIUM"),
            if (productDetailsVM.details.priceLarge != null)
              productSize(
                constraints,
                "LARGE",
              ),
          ],
        ),
      ],
    );
  }

  Widget productSize(
    BoxConstraints constraints,
    String? text,
  ) {
    String? helpTranslation;

    switch (text) {
      case "SMALL":
        helpTranslation = AppLocalizations.of(context)?.small;
        break;
      case "MEDIUM":
        helpTranslation = AppLocalizations.of(context)?.medium;
        break;
      case "LARGE":
        helpTranslation = AppLocalizations.of(context)?.large;
        break;
    }

    bool isSelected = text == widget.selectedSize;
    return GestureDetector(
      onTap: () => widget.onSizeChanged(text),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            width: 1,
            color: isSelected ? Theme.of(context).primaryColor : Colors.black12,
          ),
        ),
        margin: const EdgeInsetsDirectional.only(start: 10),
        width: constraints.maxWidth * 0.25,
        height: constraints.maxWidth * 0.08,
        child: Center(
          child: CustomText(
            text: helpTranslation ?? "",
            fontSize: 12.sp,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
