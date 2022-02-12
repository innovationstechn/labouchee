import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserModel {
  final int? id;
  final String? name;
  final DateTime? numberVerifiedAt;

  UserModel({
    required this.id,
    required this.name,
    required this.numberVerifiedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
