import 'dart:async';

import 'package:dio/dio.dart';
import 'package:labouchee/app/locator.dart';
import 'package:labouchee/constants/general.dart';
import 'package:labouchee/models/login_model.dart';
import 'package:labouchee/models/register_model.dart';
import 'package:labouchee/models/register_error_model.dart';
import 'package:labouchee/models/reset_password_error_model.dart';
import 'package:labouchee/services/api/api.dart';
import 'package:labouchee/services/api/exceptions/api_exceptions.dart';
import 'package:labouchee/services/local_storage/hive_local_storage.dart';
import 'package:labouchee/services/local_storage/local_storage.dart';

import '../../models/reset_password_model.dart';

class LaboucheeAPI implements API {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: API_ADDRESS,
      connectTimeout: API_TIMEOUT.inMilliseconds,
    ),
  );

  final LocalStorage _localStorage = locator<HiveLocalStorage>();

  LaboucheeAPI() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _localStorage.token();

          options.headers['api_key'] = API_KEY;
          options.headers['Accept'] = 'application/json';

          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          handler.next(options);
        },
      ),
    );
  }

  @override
  Future<String> login(LoginModel loginModel) async {
    try {
      final response = await _dio.post(
        '/login',
        data: loginModel,
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
        data: FormData.fromMap(
          registerModel.toJson(),
        ),
      );

      return response.data['token'];
    } on DioError catch (e) {
      if (e.response!.statusCode == 422) {
        throw ErrorModelException<RegisterValidationErrorModel>(
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

  @override
  Future<String> forgotPassword(String email) async {
    try {
      final response = await _dio.post(
        '/forgot-password',
        data: {
          'email': email,
        },
      );

      return response.data['code'];
    } on DioError catch (e) {
      if (e.response!.statusCode == 422) {
        throw NoEmailFoundException(
          e.response!.data['message'],
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

  @override
  Future<void> resetPassword(ResetPasswordModel model) async {
    try {
      final response = await _dio.post(
        '/reset-password',
        data: model.toJson(),
      );
    } on DioError catch (e) {
      if (e.response!.statusCode == 422) {
        throw ErrorModelException<ResetPasswordErrorModel>(
          e.response!.data['message'],
          ResetPasswordErrorModel.fromJson(
            e.response!.data['error'],
          ),
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
  Future<String> sendOTP() async {
    try {
      final response = await _dio.post('/send-verification-code');

      return response.data['verification_code'].toString();
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        throw ErrorModelException<int>(
          e.response!.data['message'],
          e.response!.data['verification_code'],
        );
      } else if (e.response!.statusCode != 200) {
        throw RequestFailureException(
          e.response!.data['message'] ??
              "Oops! We could not serve your request.",
        );
      }
      throw RequestFailureException(
        "No internet detected. Please check your internet connection and try again.",
      );
    }
  }
}
