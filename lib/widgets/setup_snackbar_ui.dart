import 'package:labouchee/app/locator.dart';
import 'package:labouchee/enums/snackbar_type.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

void setupSnackbarUi() {
  final service = locator<SnackbarService>();

  // Registers a config to be used when calling showSnackbar
  service.registerSnackbarConfig(SnackbarConfig(
    backgroundColor: const Color.fromRGBO(80, 32, 10, 1),
    textColor: Colors.white,
    messageColor: Colors.white,
    mainButtonTextColor: Colors.black,
  ));

  service.registerCustomSnackbarConfig(
    variant: SnackbarType.blueAndYellow,
    config: SnackbarConfig(
      backgroundColor: Colors.blueAccent,
      textColor: Colors.yellow,
      borderRadius: 1,
      dismissDirection: DismissDirection.horizontal,
    ),
  );

  service.registerCustomSnackbarConfig(
    variant: SnackbarType.greenAndRed,
    config: SnackbarConfig(
      backgroundColor: Colors.white,
      titleColor: Colors.green,
      messageColor: Color.fromRGBO(80, 32, 10, 1),
      borderRadius: 1,
    ),
  );
}
