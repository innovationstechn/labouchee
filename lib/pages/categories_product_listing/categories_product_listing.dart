import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../landing_products_list.dart';

class CategoryProductListing extends StatefulWidget {
  const CategoryProductListing({Key? key}) : super(key: key);

  @override
  _CategoryProductListingState createState() => _CategoryProductListingState();
}

class _CategoryProductListingState extends State<CategoryProductListing> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
/*          LandingProductList(items: searchVM.searched),*/
      ],
    );
  }
}
