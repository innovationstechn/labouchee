import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labouchee/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/locator.dart';
import '../../app/routes.gr.dart';
import '../../services/api/labouchee_api.dart';
import '../../widgets/custom_button.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  final _laboucheeAPI = locator<LaboucheeAPI>();
  final _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          SizedBox(
            height: constraints.maxHeight-60,
            child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
              itemCount: 40,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    displayCard(constraints),
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Divider(
                        thickness: 1.0,
                        color: Colors.black12,
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          const SizedBox(height:10),
          CustomButton(
            size: Size(
                constraints.maxWidth*0.9,
                40
            ),
            text: "CHECK OUT",
            textFontSize: 14.sp,
            // circularSize: 20,
            onTap: () {
              _navigationService.navigateTo(Routes.checkoutScreenRoute);
            },
          )
        ],
      );
    });
  }

  Widget displayCard(BoxConstraints constraints) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: constraints.maxWidth * 0.25,
            height: constraints.maxWidth * 0.28,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              child: SizedBox.expand(
                child: Image.asset(
                  "assets/images/flags/sa_flag.jpg",
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Container(
            width: constraints.maxWidth * 0.65,
            height: constraints.maxWidth * 0.28,
            padding: const EdgeInsetsDirectional.only(start: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "Golden Censor",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomText(
                  text: "asdjnksladmaslkmdasmladssssss",
                  color: Colors.black38,
                  fontSize: 14.sp,
                  maxLines: 2,
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "& 366.00",
                        color: Theme
                            .of(context)
                            .primaryColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 1),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(25.0),
                              ),
                              border: Border.all(
                                  color: Theme
                                      .of(context)
                                      .primaryColor),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: Theme
                                      .of(context)
                                      .primaryColor,
                                  size: 18.sp,
                                ),
                                CustomText(
                                  text: "1",
                                  fontSize: 14.sp,
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 3),
                                ),
                                Icon(Icons.remove,
                                    color: Theme
                                        .of(context)
                                        .primaryColor,
                                    size: 18.sp),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Icon(Icons.delete,
                              color: Theme
                                  .of(context)
                                  .primaryColor,
                              size: 20.sp),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
