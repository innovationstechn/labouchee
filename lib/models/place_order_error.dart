import 'package:json_annotation/json_annotation.dart';

part 'place_order_error.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PlaceOrderErrorModel {
  final List<String>? name,
      address,
      phone,
      city,
      email,
      paymentMethod,
      branch,
      bookingTime,
      bookingDate,
      notes;

  PlaceOrderErrorModel({
    this.name,
    this.address,
    this.phone,
    this.city,
    this.email,
    this.paymentMethod,
    this.branch,
    this.notes,
    this.bookingTime,
    this.bookingDate,
  });

  factory PlaceOrderErrorModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceOrderErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceOrderErrorModelToJson(this);
}
