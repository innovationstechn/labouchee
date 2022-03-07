import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labouchee/models/cart_detail.dart';
import 'package:labouchee/models/cart_item.dart';
import 'package:labouchee/pages/checkout/checkout_viewmodel.dart';
import 'package:labouchee/widgets/custom_app_bar.dart';
import 'package:labouchee/widgets/custom_button.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/locator.dart';
import '../../app/routes.gr.dart';
import '../../services/navigator.dart';
import '../../widgets/custom_text.dart';
import 'package:xml/xml.dart';
import 'package:sdk/components/network_helper.dart';
import 'package:sdk/screens/webview_screen.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({Key? key}) : super(key: key);

  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  PanelController panelController = PanelController();
  final _navigationService = locator<NavigatorService>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 50,
            leading: const BackButton(color: Colors.black),
            title: CustomText(
              text: "Check Out",
              fontWeight: FontWeight.bold,
              fontSize: 15.sp,
            ),
            titleTextStyle: const TextStyle(color: Colors.black),
            backgroundColor: Colors.white,
          ),
          body: ViewModelBuilder<CheckoutVM>.reactive(
              viewModelBuilder: () => CheckoutVM(),
              onModelReady: (model) => model.initialize(),
              builder: (context, checkoutVM, _) {
                if (checkoutVM.isBusy) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return Stack(
                  children: [
                    SizedBox(
                      height: constraints.maxHeight * 0.8,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return displayProduct(constraints,
                              checkoutVM.details!.cart!.items![index]);
                        },
                        itemCount: checkoutVM.details!.cart!.items!.length,
                      ),
                    ),
                    SlidingUpPanel(
                      controller: panelController,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(18.0),
                          topRight: Radius.circular(18.0)),
                      maxHeight: 200,
                      minHeight: 200,
                      panelBuilder: (sc) => _panel(
                        sc,
                        checkoutVM.details!.cartInfo!,
                      ),
                      onPanelSlide: (double pos) => setState(() {}),
                    )
                  ],
                );
              }),
        ),
      );
    });
  }

  Widget _panel(ScrollController controller, CartDetailInfoModel info) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 150,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsetsDirectional.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 30,
                      height: 5,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.0))),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "Have you a coupon code?",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                    ),
                    CustomText(
                      text: "APPLY COUPON",
                      color: Theme.of(context).primaryColor,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "Coupon Off:",
                      fontSize: 12.sp,
                      // fontWeight:,
                    ),
                    CustomText(
                      text: "SAR ${info.discountAmount?.toString() ?? 0}",
                      fontSize: 13.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "Shipping Cost:",
                      fontSize: 12.sp,
                    ),
                    CustomText(
                      text: "SAR ${info.shipping?.toString() ?? 0}",
                      fontSize: 13.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "Total Cost:",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      text: "SAR ${info.totalPrice?.toString() ?? '?'}",
                      fontSize: 13.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        CustomButton(
          size: const Size(double.infinity, 50),
          text: "PAY SAR ${info.totalPrice?.toString() ?? '?'}",
          textFontSize: 14.sp,
          // circularSize: 20,
          onTap: () {
            _navigationService.router.navigate(
              PlaceOrderScreenRoute(),
            );
          },
        ),
      ],
    );
  }

  Widget displayProduct(BoxConstraints constraints, CartItemModel item) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...?item.size
            ?.map(
              (e) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: constraints.maxWidth * 0.25,
                          height: constraints.maxWidth * 0.2,
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            child: SizedBox.expand(
                              child: Image.network(
                                item.image!,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            CustomText(
                              text: item.totalAmount.toString(),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 1),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(25.0),
                                ),
                                border: Border.all(
                                    color: Theme.of(context).primaryColor),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: Theme.of(context).primaryColor,
                                    size: 18.sp,
                                  ),
                                  CustomText(
                                    text: e.quantity!.toString(),
                                    fontSize: 14.sp,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 3,
                                    ),
                                  ),
                                  Icon(
                                    Icons.remove,
                                    color: Theme.of(context).primaryColor,
                                    size: 18.sp,
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    CustomText(
                      padding: const EdgeInsetsDirectional.only(top: 10),
                      text: item.title!,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 10),
                    Divider(
                      color: Theme.of(context).primaryColor,
                      thickness: 2,
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ],
    );
  }

//   void telrPayment() {
//     final builder = XmlBuilder();
//     builder.processing('xml', 'version="1.0"');
//     builder.element('mobile', nest: () {
//       builder.element('store', nest: () {
//         builder.text('15996');
//       });
//       builder.element('key', nest: () {
//         builder.text('pQ6nP-7rHt@5WRFv');
//       });
//
//       builder.element('device', nest: () {
//         builder.element('type', nest: () {
//           builder.text('iOS');
//         });
//         builder.element('id', nest: () {
//           builder.text('37fb44a2ec8202a3');
//         });
//       });
//
// // app
//       builder.element('app', nest: () {
//         builder.element('name', nest: () {
//           builder.text('Telr');
//         });
//         builder.element('version', nest: () {
//           builder.text('1.1.6');
//         });
//         builder.element('user', nest: () {
//           builder.text('2');
//         });
//         builder.element('id', nest: () {
//           builder.text('123');
//         });
//       });
//
// //tran
//       builder.element('tran', nest: () {
//         builder.element('test', nest: () {
//           builder.text('1');
//         });
//         builder.element('type', nest: () {
//           builder.text('auth');
//         });
//         builder.element('class', nest: () {
//           builder.text('paypage');
//         });
//         builder.element('cartid', nest: () {
//           builder.text(100000000 + 1321);
//         });
//         builder.element('description', nest: () {
//           builder.text('Test for Mobile API order');
//         });
//         builder.element('currency', nest: () {
//           builder.text("aed");
//         });
//         builder.element('amount', nest: () {
//           builder.text("3");
//         });
//         builder.element('language', nest: () {
//           builder.text("en");
//         });
//         builder.element('firstref', nest: () {
//           builder.text('first');
//         });
//         builder.element('ref', nest: () {
//           builder.text('null');
//         });
//       });
//
// //billing
//       builder.element('billing', nest: () {
// // name
//         builder.element('name', nest: () {
//           builder.element('title', nest: () {
//             builder.text('Hellosass');
//           });
//           builder.element('first', nest: () {
//             builder.text('Div');
//           });
//           builder.element('last', nest: () {
//             builder.text('V');
//           });
//         });
// //custref savedcard
//         builder.element('custref', nest: () {
//           builder.text('231');
//         });
//
// // address
//         builder.element('address', nest: () {
//           builder.element('line1', nest: () {
//             builder.text('Dubai');
//           });
//           builder.element('city', nest: () {
//             builder.text('Dubai');
//           });
//           builder.element('region', nest: () {
//             builder.text('');
//           });
//           builder.element('country', nest: () {
//             builder.text('AE');
//           });
//         });
//
//         builder.element('phone', nest: () {
//           builder.text('551188269');
//         });
//         builder.element('email', nest: () {
//           builder.text('divya.thampi@telr.com');
//         });
//       });
//     });
//
//     final bookshelfXml = builder.buildDocument();
//
// // print(bookshelfXml);
//     pay(bookshelfXml);
//   }
//
//   void pay(XmlDocument xml) async {
//     NetworkHelper _networkHelper = NetworkHelper();
//     var response = await _networkHelper.pay(xml);
//     print(response);
//     if (response == 'failed' || response == null) {
// // failed
// //       alertShow('Failed');
//     } else {
//       var _url;
//       final doc = XmlDocument.parse(response);
//       final url = doc.findAllElements('start').map((node) => node.text);
//       final code = doc.findAllElements('code').map((node) => node.text);
//       print(url);
//       _url = url.toString();
//       String _code = code.toString();
//       if (_url.length > 2) {
//         _url = _url.replaceAll('(', '');
//         _url = _url.replaceAll(')', '');
//         _code = _code.replaceAll('(', '');
//         _code = _code.replaceAll(')', '');
//         _launchURL(_url, _code);
//       }
//       print(_url);
//       final message = doc.findAllElements('message').map((node) => node.text);
//       print('Message =  $message');
//       if (message.toString().length > 2) {
//         String msg = message.toString();
//         msg = msg.replaceAll('(', '');
//         msg = msg.replaceAll(')', '');
//         // alertShow(msg);
//       }
//     }
//   }

  void _launchURL(String url, String code) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => WebViewScreen(
                  url: url,
                  code: code,
                )));
  }
}
