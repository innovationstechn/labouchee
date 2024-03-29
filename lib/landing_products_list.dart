import 'package:flutter/cupertino.dart';
import 'package:labouchee/product_card.dart';
import 'models/product.dart';

class LandingProductList extends StatelessWidget {
  final List<ProductModel>? items;

  const LandingProductList({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverLayoutBuilder(builder: (context, constraints) {

      final hItemCount = 2;

      return SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return ProductCard(
              selectedItemIndex: index,
              isSmall: false,
              similarModel: items!,
            );
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
