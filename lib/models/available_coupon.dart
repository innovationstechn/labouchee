import 'package:json_annotation/json_annotation.dart';

part 'available_coupon.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AvailableCouponModel {
  final String? code,
      amount,
      description,
      startDate,
      title,
      validTill,
      status,
      validFrom;

  AvailableCouponModel({
    this.code,
    this.amount,
    this.description,
    this.startDate,
    this.title,
    this.validTill,
    this.status,
    this.validFrom,
  });

  factory AvailableCouponModel.fromJson(Map<String, dynamic> json) =>
      _$AvailableCouponModelFromJson(json);

  Map<String, dynamic> toJson() => _$AvailableCouponModelToJson(this);
}
