import 'package:flutter/material.dart';
import 'package:labouchee/pages/otp/otp_viewmodel.dart';
import 'package:stacked/stacked.dart';

class OtpView extends StatelessWidget {
  OtpView({Key? key}) : super(key: key);
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewModelBuilder<OtpVM>.reactive(
        viewModelBuilder: () => OtpVM(),
        onModelReady: (model) => model.sendOTP(),
        builder: (context, otpVM, _) {
          if (otpVM.isBusy) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return otpField(otpVM);
        },
      ),
    );
  }

  Widget otpField(OtpVM otpVM) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: otpController,
        ),
        ElevatedButton(
          onPressed: () => otpVM.match(otpController.text),
          child: const Text('Match OTP'),
        ),
      ],
    );
  }
}
