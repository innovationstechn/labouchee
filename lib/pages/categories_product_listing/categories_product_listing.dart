import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labouchee/models/category.dart';
import 'package:labouchee/pages/categories_product_listing/categories_product_listing_viewmodel.dart';
import 'package:labouchee/widgets/custom_app_bar.dart';
import 'package:stacked/stacked.dart';

import '../../landing_products_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: widget.category.name,),
      body: ViewModelBuilder<CategoryProductListingVM>.reactive(
        viewModelBuilder: () =>
            CategoryProductListingVM(categoryModel: widget.category),
        onModelReady: (model) => model.initialize(),
        builder: (context, categoryVM, _) {
          if (categoryVM.isBusy) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: CustomScrollView(
              slivers: [
                LandingProductList(items: categoryVM.products),
              ],
            ),
          );
        },
      ),
    );
  }
}
