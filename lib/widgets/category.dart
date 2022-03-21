import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/locator.dart';
import '../app/routes.gr.dart';
import '../models/category.dart';
import '../services/navigator.dart';
import 'custom_cached_image.dart';
import 'custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Category extends StatefulWidget {
  final List<CategoryModel> categories;
  final BoxConstraints constraints;

  const Category({Key? key, required this.categories, required this.constraints}) : super(key: key);

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
                  color: Theme.of(context).primaryColor,
                  fontSize: 14.sp,
                  onTap: () =>
                    _navigationService.router.navigate(
                      CategoriesListingScreenRoute(
                          categories: widget.categories),
                    )
                  ),
            ],
          ),
        ),
        Padding(
            padding: EdgeInsets.all(widget.constraints.maxWidth*0.01),
            child: Wrap(
              direction: Axis.horizontal,
              children: [
                for (int index = 0; index < widget.categories.length; index++)
                  if (index < 6)
                    SizedBox(
                        // height: widget.constraints.maxHeight*0.15,
                        width: widget.constraints.maxWidth*0.32,
                        child: categoryCard(widget.categories[index]))
              ],
            )),
      ],
    );
  }

  Widget categoryCard(CategoryModel categoryModel) {
    return GestureDetector(
      onTap: () => _navigationService.router.navigate(
        CategoryProductListingScreenRoute(category: categoryModel),
      ),
      child: Column(
        children: [
          Container(
            width: widget.constraints.maxWidth*0.22,
            height: widget.constraints.maxWidth*0.22,
            child: CustomCachedImage(
              image: categoryModel.photo!,
              boxFit: BoxFit.contain,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          CustomText(
            text:categoryModel.name!,
              fontSize: 10.sp,
              fontWeight: FontWeight.normal,
              padding: EdgeInsets.symmetric(vertical: 5),
            ),
        ],
      ),
    );
  }
}
