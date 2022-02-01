import 'package:json_annotation/json_annotation.dart';

part 'register_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class RegisterModel {
  final String name, email, password, zipCode, contactNo;
  @JsonKey(name: 'address[]')
  final String address1;
  @JsonKey(ignore: true)
  final String? address2;

  RegisterModel({
    required this.name,
    required this.email,
    required this.password,
    required this.address1,
    required this.zipCode,
    required this.contactNo,
    this.address2,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterModelFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterModelToJson(this);
}
