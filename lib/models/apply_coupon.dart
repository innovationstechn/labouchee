import 'package:json_annotation/json_annotation.dart';

part 'apply_coupon.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ApplyCouponModel {
  final String? mobileId, coupon;

  ApplyCouponModel({
    this.mobileId,
    this.coupon,
  });

  factory ApplyCouponModel.fromJson(Map<String, dynamic> json) =>
      _$ApplyCouponModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApplyCouponModelToJson(this);
}
