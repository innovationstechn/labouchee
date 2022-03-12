import 'package:json_annotation/json_annotation.dart';

part 'cart_update.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class CartUpdateModel {
  final int? product, quantity;
  final String? type, size;

  CartUpdateModel({
    this.product,
    this.quantity,
    this.type,
    this.size,
  });

  factory CartUpdateModel.fromJson(Map<String, dynamic> json) =>
      _$CartUpdateModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartUpdateModelToJson(this);
}
