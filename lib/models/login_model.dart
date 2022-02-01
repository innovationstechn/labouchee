import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LoginModel {
  String email, password;

  LoginModel({
    required this.email,
    required this.password,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}
