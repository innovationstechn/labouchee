import 'package:flutter/material.dart';
import 'package:labouchee/pages/register/register_viewmodel.dart';
import 'package:stacked/stacked.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterVM>.reactive(
      viewModelBuilder: () => RegisterVM(),
      onModelReady: (model) {
        Future.delayed(
          const Duration(seconds: 2),
          () {
            model.register(
              name: 'tester2',
              email: 'tester2@t.com',
              password: '1234567890',
              address1: "abc",
              address2: 'def',
              zipCode: '2323232323',
              contactNo: '125455535558',
            );
          },
        );
      },
      builder: (context, registerVM, _) {
        return const Scaffold(
          body: Center(
            child: Text('This is register page'),
          ),
        );
      },
    );
  }
}
