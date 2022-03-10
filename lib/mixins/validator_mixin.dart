import 'package:email_validator/email_validator.dart';

import '../constants/strings.dart';

mixin ValidatorMixin{
  String? emailValidator(String? email){
    if(EmailValidator.validate(email!)) {
      return null;
    } else {
      if(email.isEmpty) {
        return Strings.emailEmpty;
      }else{
        return Strings.invalidEmail;
      }
    }
  }

  String? passwordValidator(String? password){
    if(password!.isNotEmpty) {
      return null;
    } else {
      if(password.isEmpty){
        return Strings.passwordEmpty;
      }else{
        return Strings.invalidPassword;
      }

    }
  }

  String? contactNoValidator(String? contactNo){
    if(contactNo!.isNotEmpty) {
      return null;
    } else {
      if(contactNo.isEmpty){
        return Strings.contactEmpty;
      }

    }
  }

  String? postalCodeValidator(String? postalCode){
    if(postalCode!.isNotEmpty) {
      return null;
    } else {
      return "POSTAL CODE SHOULD NOT BE EMPTY";
    }
  }

  String? addressValidator(String? address){
    if(address!.isNotEmpty) {
      return null;
    } else {
      return Strings.addressEmpty;
    }
  }

  String? nameValidator(String? name){
    if(name!.isNotEmpty) {
      return null;
    } else {
      return Strings.nameEmpty;
    }

  }
}