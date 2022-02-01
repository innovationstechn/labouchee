import '../../models/login_model.dart';
import '../../models/register_model.dart';

abstract class API {
  Future<String> register(RegisterModel registerModel);
  Future<String> login(LoginModel loginModel);
}
