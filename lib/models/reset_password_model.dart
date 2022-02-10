import 'package:json_annotation/json_annotation.dart';

part 'reset_password_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ResetPasswordModel {
  final String email, password, code;

  ResetPasswordModel({
    required this.email,
    required this.password,
    required this.code,
  });

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordModelToJson(this);
}
