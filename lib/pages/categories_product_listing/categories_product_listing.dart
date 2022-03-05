import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labouchee/models/category.dart';
import 'package:labouchee/pages/categories_product_listing/categories_product_listing_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../landing_products_list.dart';

class CategoryProductListing extends StatefulWidget {
  final CategoryModel category;

  const CategoryProductListing({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  _CategoryProductListingState createState() => _CategoryProductListingState();
}

class _CategoryProductListingState extends State<CategoryProductListing> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CategoryProductListingVM>.reactive(
      viewModelBuilder: () =>
          CategoryProductListingVM(categoryModel: widget.category),
      builder: (context, categoryVM, _) {
        return CustomScrollView(
          slivers: [
            LandingProductList(items: categoryVM.products),
          ],
        );
      },
    );
  }
}