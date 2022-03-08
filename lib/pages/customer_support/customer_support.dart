import 'package:flutter/material.dart';
import 'package:labouchee/pages/customer_support/customer_support_viewmodel.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class CustomerSupport extends StatefulWidget {
  const CustomerSupport({Key? key}) : super(key: key);

  @override
  _CustomerSupportState createState() => _CustomerSupportState();
}

class _CustomerSupportState extends State<CustomerSupport> {
  final TextEditingController subject = TextEditingController(),
      inquiry = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: AppLocalizations.of(context)!.inquiryForm),
        body: LayoutBuilder(builder: (context, constraints) {
          return ViewModelBuilder<CustomerSupportVM>.reactive(
              viewModelBuilder: () => CustomerSupportVM(),
              builder: (context, customerSupportVM, _) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        enableSuggestions: true,
                        autofocus: true,
                        controller: subject,
                        style: TextStyle(color: Colors.black, fontSize: 13.sp),
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.title,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: Theme.of(context).primaryColor)),
                        height: 150,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextFormField(
                            maxLines: 7,
                            controller: inquiry,
                            style: TextStyle(
                                fontSize: 14.sp,
                                letterSpacing: 1.0,
                                height: 1.5),
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration.collapsed(
                              hintText: AppLocalizations.of(context)!.note,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        text: AppLocalizations.of(context)!.submit,
                        size: Size(constraints.maxWidth - 50, 50),
                        onTap: () => customerSupportVM.submit(
                            subject.text, inquiry.text),
                      )
                    ],
                  ),
                );
              });
        }),
      ),
    );
  }
}
