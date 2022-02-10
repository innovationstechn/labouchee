import 'package:json_annotation/json_annotation.dart';

part 'reset_password_error_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ResetPasswordErrorModel {
  final List<String>? email, password, code;

  ResetPasswordErrorModel({
    required this.email,
    required this.password,
    required this.code,
  });

  factory ResetPasswordErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordErrorModelToJson(this);
}
