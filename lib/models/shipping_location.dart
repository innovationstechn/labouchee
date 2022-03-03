import 'package:json_annotation/json_annotation.dart';

part 'shipping_location.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ShippingLocationModel {
  final int? id;
  final String? location, isEnabled, amount, name;

  ShippingLocationModel({
    this.id,
    this.location,
    this.isEnabled,
    this.amount,
    this.name,
  });

  factory ShippingLocationModel.fromJson(Map<String, dynamic> json) =>
      _$ShippingLocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingLocationModelToJson(this);
}
