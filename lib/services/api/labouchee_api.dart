import 'package:dio/dio.dart';
import 'package:labouchee/constants/general.dart';
import 'package:labouchee/models/login_model.dart';
import 'package:labouchee/models/register_model.dart';
import 'package:labouchee/models/register_error_model.dart';
import 'package:labouchee/services/api/api.dart';
import 'package:labouchee/services/api/exceptions/api_exceptions.dart';

class LaboucheeAPI implements API {
  final Dio _dio = Dio(
    BaseOptions(
        baseUrl: API_ADDRESS, connectTimeout: API_TIMEOUT.inMilliseconds),
  );

  @override
  Future<String> login(LoginModel loginModel) async {
    try {
      final response = await _dio.post(
        '/login',
        data: loginModel,
        options: Options(
          headers: {
            'api_key': API_KEY,
          },
        ),
      );

      return response.data['token'];
    } on DioError catch (e) {
      if (e.response!.statusCode == 401) {
        throw UnauthorisedException(
          e.response!.data['message'],
        );
      } else if (e.response!.statusCode != 200) {
        throw RequestFailureException(
          e.response!.data['message'] ??
              "Oops! We could not serve your request.",
        );
      } else {
        throw RequestFailureException(
          "No internet detected. Please check your internet connection and try again.",
        );
      }
    }
  }

  @override
  Future<String> register(RegisterModel registerModel) async {
    try {
      final response = await _dio.post(
        '/register',
        data: FormData.fromMap(registerModel.toJson()),
        options: Options(
          headers: {'api_key': API_KEY, "Accept": "application/json"},
        ),
      );

      return response.data['token'];
    } on DioError catch (e) {
      if (e.response!.statusCode == 422) {
        throw RegisterValidationException(
          e.response!.data['message'],
          RegisterValidationErrorModel.fromJson(
            e.response!.data['errors'],
          ),
        );
      } else if (e.response!.statusCode != 200) {
        throw RequestFailureException(
          e.response!.data['message'] ??
              "Oops! We could not serve your request.",
        );
      } else {
        throw RequestFailureException(
          "Oops! We could not serve your request.",
        );
      }
    }
  }
}
