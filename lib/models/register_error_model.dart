import 'package:json_annotation/json_annotation.dart';

part 'register_error_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class RegisterValidationErrorModel {
  final List<String>? name,
      email,
      password,
      address1,
      address2,
      zipCode,
      contactNo;

  RegisterValidationErrorModel({
    required this.name,
    required this.email,
    required this.password,
    required this.address1,
    required this.address2,
    required this.zipCode,
    required this.contactNo,
  });

  factory RegisterValidationErrorModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterValidationErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterValidationErrorModelToJson(this);
}
