import 'package:labouchee/models/register_error_model.dart';

class ErrorModelException<T> implements Exception {
  final T error;
  final String message;

  ErrorModelException(this.message, this.error);
}

class CustomException implements Exception {
  final String _message;
  final String _prefix;

  CustomException(this._message, this._prefix);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class RequestFailureException extends CustomException {
  RequestFailureException(String message) : super(message, "");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException(message) : super(message, "");
}

class InvalidOTPException extends CustomException {
  InvalidOTPException(message) : super(message, "");
}

class NoEmailFoundException extends CustomException {
  NoEmailFoundException(message) : super(message, "");
}
