import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserModel {
  final int? id;
  final String? name, email, avatar, contactNo, zipCode, city;
  final DateTime? numberVerifiedAt,
      emailVerifiedAt,
      deletedAt,
      createdAt,
      updatedAt;
  final List<String>? address;
  @JsonKey(fromJson: _boolFromString, toJson: _boolToString)
  final bool? isBlocked, welcomeUser, signupCouponUsed;

  UserModel({
    this.id,
    this.email,
    this.name,
    this.avatar,
    this.contactNo,
    this.zipCode,
    this.city,
    this.numberVerifiedAt,
    this.emailVerifiedAt,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.address,
    this.isBlocked,
    this.welcomeUser,
    this.signupCouponUsed,
  });

  static String? _boolToString(bool? b) => b == null ? null : b ? '1' : '0';
  static bool? _boolFromString(String? s) => s == null ? null : s == '1';

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
