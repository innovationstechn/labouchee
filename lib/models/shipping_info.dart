import 'package:json_annotation/json_annotation.dart';

part 'shipping_info.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ShippingInfoModel {
  @JsonKey(
    fromJson: _stringFromUnknown,
    toJson: _intToJson,
  )
  final String? city;
  final String? shippingCost, isEnabled, cityName;

  ShippingInfoModel({
    this.city,
    this.shippingCost,
    this.isEnabled,
    this.cityName,
  });

  static String? _stringFromUnknown(Object? o) => o?.toString();

  static int? _intToJson(String? s) => s == null ? null : int.tryParse(s);

  factory ShippingInfoModel.fromJson(Map<String, dynamic> json) =>
      _$ShippingInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingInfoModelToJson(this);
}
