import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:labouchee/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: SizedBox.expand(
              child: Image.asset(
                "assets/images/flags/logo.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
          Expanded(
            child: SlidingUpPanel(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(18.0),
                    topRight: Radius.circular(18.0)),
                maxHeight: constraints.maxHeight * 0.85,
                minHeight: constraints.maxHeight * 0.7,
                panel: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: constraints.minWidth * 0.25,
                              height: constraints.maxWidth * 0.2,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  border: Border.all(
                                      color: Theme.of(context).primaryColor)),
                              child: Image.asset(
                                "assets/images/flags/logo.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              width: constraints.minWidth * 0.25,
                              height: constraints.maxWidth * 0.2,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  border: Border.all(
                                      color: Theme.of(context).primaryColor)),
                              child: Image.asset(
                                "assets/images/flags/logo.png",
                                fit: BoxFit.fill,
                              ),
                            )
                          ],
                        ),
                        CustomText(
                          text: "Select size:",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          padding: EdgeInsets.all(10),
                        ),
                        Row(
                          children: [
                            productSize(constraints),
                            productSize(constraints),
                            productSize(constraints),
                          ],
                        )
                      ],
                    ),
                  ),
                )),
          )
        ],
      );
    });
  }

}
