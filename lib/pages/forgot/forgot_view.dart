import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'forgot_viewmodel.dart';

class ForgotView extends StatelessWidget {
  ForgotView({Key? key}) : super(key: key);
  final TextEditingController otpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewModelBuilder<ForgotVM>.reactive(
        viewModelBuilder: () => ForgotVM(),
        builder: (context, forgotVM, _) {
          if (forgotVM.isBusy) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (forgotVM.takeOTPCode) {
            return otpPassFields(forgotVM);
          } else {
            return emailField(forgotVM);
          }
        },
      ),
    );
  }

  Widget emailField(ForgotVM forgotVM) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: emailController,
        ),
        ElevatedButton(
          onPressed: () => forgotVM.forgot(emailController.text),
          child: const Text('Send OTP'),
        ),
      ],
    );
  }

  Widget otpPassFields(ForgotVM forgotVM) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: otpController,
        ),
        TextField(
          controller: passwordController,
        ),
        ElevatedButton(
          onPressed: () => forgotVM.reset(emailController.text,
              passwordController.text, otpController.text),
          child: const Text('Reset'),
        ),
      ],
    );
  }
}
