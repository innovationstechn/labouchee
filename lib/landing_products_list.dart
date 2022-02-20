import 'package:flutter/cupertino.dart';
import 'package:labouchee/product_card.dart';
import 'package:sizer/sizer.dart';

import 'models/product.dart';

class LandingProductList extends StatelessWidget {
  final List<ProductModel?>? items;

  const LandingProductList({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverLayoutBuilder(builder: (context, constraints) {
      final orientation = MediaQuery.of(context).orientation;
      final width = constraints.asBoxConstraints().maxWidth;

      final hItemCount = 2;

      return SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Container(
                child:
                    ProductCard(productModel: items![index], isSmall: false));
          },
          childCount: items!.length,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: hItemCount.round(),
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
        ),
      );
    });
  }
}
