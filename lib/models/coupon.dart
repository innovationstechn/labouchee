import 'package:json_annotation/json_annotation.dart';

part 'coupon.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CouponModel {
  final String? mobileId, coupon;

  CouponModel({
    this.mobileId,
    this.coupon,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) =>
      _$CouponModelFromJson(json);
  Map<String, dynamic> toJson() => _$CouponModelToJson(this);
}
