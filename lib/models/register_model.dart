import 'package:json_annotation/json_annotation.dart';

part 'register_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class RegisterModel {
  final String name, email, password, zipCode, contactNo;
  @JsonKey(ignore: true)
  final String? address1, address2;

  RegisterModel({
    required this.name,
    required this.email,
    required this.password,
    required this.zipCode,
    required this.contactNo,
    this.address1,
    this.address2,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterModelFromJson(json);
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = _$RegisterModelToJson(this);

    if (address2 != null) {
      map['address[]'] = [address1, address2];
    } else {
      map['address[]'] = [address1];
    }

    return map;
  }
}
