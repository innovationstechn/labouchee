import 'package:email_validator/email_validator.dart';

mixin ValidatorMixin{
  String? emailValidator(String? email){
    if(EmailValidator.validate(email!)) {
      return null;
    } else {
      if(email.isEmpty) {
        return "EMAIL SHOULD NOT BE EMPTY";
      }else{
        return "INVALID EMAIL";
      }
    }
  }

  String? passwordValidator(String? password){
    if(password!.isNotEmpty) {
      return null;
    } else {
      if(password.isEmpty){
        return "PASSWORD SHOULD NOT BE EMPTY";
      }else{
        return "INVALID PASSWORD";
      }

    }
  }

  String? contactNoValidator(String? contactNo){
    if(contactNo!.isNotEmpty) {
      return null;
    } else {
      if(contactNo.isEmpty){
        return "CONTACT NUMBER SHOULD NOT BE EMPTY";
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
      return "ADDRESS SHOULD NOT BE EMPTY";
    }
  }

  String? nameValidator(String? name){
    if(name!.isNotEmpty) {
      return null;
    } else {
      return "NAME SHOULD NOT BE EMPTY";
    }

  }
}