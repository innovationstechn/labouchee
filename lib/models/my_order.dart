import 'package:json_annotation/json_annotation.dart';

part 'my_order.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MyOrderModel {
  final int? id;
  final double? orderAmount;
  final String? orderDetails, orderStatus, createdTime, status;

  MyOrderModel({
    this.id,
    this.orderAmount,
    this.orderDetails,
    this.orderStatus,
    this.createdTime,
    this.status,
  });

  factory MyOrderModel.fromJson(Map<String, dynamic> json) =>
      _$MyOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyOrderModelToJson(this);
}
