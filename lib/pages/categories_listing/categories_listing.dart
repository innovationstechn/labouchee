import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labouchee/app/locator.dart';
import 'package:labouchee/widgets/custom_app_bar.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/routes.gr.dart';
import '../../models/category.dart';
import '../../services/navigator.dart';
import '../categories_product_listing/categories_product_listing.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class CategoriesListing extends StatefulWidget {
  final List<CategoryModel> categories;

  const CategoriesListing({Key? key, required this.categories})
      : super(key: key);

  @override
  _CategoriesListingState createState() => _CategoriesListingState();
}

class _CategoriesListingState extends State<CategoriesListing> {
  final _navigationService = locator<NavigatorService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: AppLocalizations.of(context)!.categories),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(1.w),
          child: Wrap(
            direction: Axis.horizontal,
            children: [
              ...widget.categories.map((item) => Container(
                  height: 15.h, width: 32.w, child: categoryCard(item)))
            ],
          ),
        ),
      ),
    );
  }

  Widget categoryCard(CategoryModel categoryModel) {
    return GestureDetector(
      onTap: () => _navigationService.router
          .navigate(CategoryProductListingScreenRoute(category: categoryModel)),
      child: Column(
        children: [
          Image.network(categoryModel.photo!, width: 32.w, height: 10.h),
          const SizedBox(
            height: 8,
          ),
          Text(
            categoryModel.name!,
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
