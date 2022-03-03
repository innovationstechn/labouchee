import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/locator.dart';
import '../../app/routes.gr.dart';
import '../../models/category.dart';
import '../../widgets/custom_text.dart';

class Category extends StatefulWidget {
  final List<CategoryModel> categories;

  const Category({Key? key, required this.categories}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  final _navigationService = locator<NavigationService>();

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
                text: "Category",
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
              CustomText(
                  text: "View All",
                  color: Theme.of(context).primaryColor,
                  onTap: () {
                    _navigationService.navigateTo(
                        Routes.categoriesListingScreenRoute,
                        arguments: CategoriesListingArguments(
                            categories: widget.categories));
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
      onTap: () {},
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
