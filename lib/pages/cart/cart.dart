import 'package:flutter/cupertino.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:labouchee/landing_products_list.dart';
import 'package:labouchee/models/product.dart';
import 'package:labouchee/models/product_filter.dart';

import '../../app/locator.dart';
import '../../services/api/labouchee_api.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

// Balke wo bhi nahi jis ma product aa rahi wo kidhr ha. api call? Han jo main page par aa rahi.
// Yar jo home page par aa rahi usi endpoitn sa aa rahi hy Wo yaha lai jae. Isa padding kese deta
// Language wala page ko open kia jae click karne par. Dawai kha kar so ja. Sir ragra jae jitna ho raha.ir rest karay
// Sir rest hota rahe ga. Acha last kar da. Page open kia jae. konsa. Languge change wala

class _CartState extends State<Cart> {
  final _laboucheeAPI = locator<LaboucheeAPI>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductModel>>(
        future: _laboucheeAPI.fetchProducts(ProductFilterModel()), // done
        builder: (context, snapshot) {
          if (!snapshot.hasData) Loader();

         return Padding(
           padding: const EdgeInsets.all(8.0),
           child: CustomScrollView(
              slivers: [
                LandingProductList(items: snapshot.data)
              ],
            ),
         );
        });
  }
}
