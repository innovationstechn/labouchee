import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/locator.dart';
import '../../app/routes.gr.dart';
import '../../models/category.dart';
import '../../services/navigator.dart';
import '../../widgets/custom_cached_image.dart';
import '../../widgets/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class Category extends StatefulWidget {
  final List<CategoryModel> categories;

  const Category({Key? key, required this.categories}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  final _navigationService = locator<NavigatorService>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: AppLocalizations.of(context)!.category,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
              CustomText(
                  text: AppLocalizations.of(context)!.viewAll,
                  color: Theme
                      .of(context)
                      .primaryColor,
                  onTap: () {
                    _navigationService.router.navigate(
                      CategoriesListingScreenRoute(
                          categories: widget.categories),
                    );
                  }),
            ],
          ),
        ),
        SizedBox(
          height: 30.h,
          child: Padding(
              padding: EdgeInsets.all(1.w),
              child: Wrap(
                direction: Axis.horizontal,
                children: [
                  for (int index = 0; index < widget.categories.length; index++)
                    if (index < 6)
                      SizedBox(
                          height: 15.h,
                          width: 32.w,
                          child: categoryCard(widget.categories[index]))
                ],
              )),
        ),
      ],
    );
  }

  Widget categoryCard(CategoryModel categoryModel) {
    return GestureDetector(
      onTap: () =>
          _navigationService.router.navigate(
           CategoryProductListingScreenRoute(
                category: categoryModel),
          ),
      child: Column(
        children: [
          Container(
            width: 32.w,
            height: 10.h,
            child: CustomCachedImage(
              image: categoryModel.photo!,
              boxFit: BoxFit.contain,
            ),
          ),
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
