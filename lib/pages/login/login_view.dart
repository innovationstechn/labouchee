import 'package:flutter/material.dart';
import 'package:labouchee/pages/login/login_viewmodel.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginVM>.reactive(
      viewModelBuilder: () => LoginVM(),
      onModelReady: (model) {
        Future.delayed(
          Duration(seconds: 2),
          () {
            // model.login('pubgboy582@gmail.com', 'pakistan');
            model.login('pubgboy582@gmail.com', 'pakistanss');
          },
        );
      },
      builder: (context, loginVM, _) {
        return const Scaffold(
          body: Center(
            child: Text('This is login page'),
          ),
        );
      },
    );
  }
}
