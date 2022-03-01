import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OrderModel {
  final int? id;
  @JsonKey(name: 'order_details')
  final String? details;
  final String? status;
  @JsonKey(name: 'created_time')
  final DateTime? created;
  @JsonKey(name: 'order_amount')
  final double? amount;
  final String? orderStatus;

  OrderModel({
    this.id,
    this.details,
    this.status,
    this.created,
    this.amount,
    this.orderStatus,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
