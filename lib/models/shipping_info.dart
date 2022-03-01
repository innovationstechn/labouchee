import 'package:json_annotation/json_annotation.dart';

part 'shipping_info.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ShippingInfoModel {
  final String? city, shippingCost, isEnabled;

  ShippingInfoModel({
    this.city,
    this.shippingCost,
    this.isEnabled,
  });

  factory ShippingInfoModel.fromJson(Map<String, dynamic> json) =>
      _$ShippingInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingInfoModelToJson(this);
}
