import 'package:labouchee/models/reset_password_model.dart';

import '../../models/login_model.dart';
import '../../models/register_model.dart';

abstract class API {
  Future<String> register(RegisterModel registerModel);
  Future<String> login(LoginModel loginModel);
  Future<String> forgotPassword(String email);
  Future<void> resetPassword(ResetPasswordModel model);
  Future<String> sendOTP();
}