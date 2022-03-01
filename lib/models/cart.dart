import 'package:json_annotation/json_annotation.dart';

import 'cart_item.dart';

part 'cart.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CartModel {
  final List<CartItemModel>? items;
  @JsonKey(name: 'productCount')
  final int? totalItems;
  final String? coupon;

  CartModel({
    this.items,
    this.totalItems,
    this.coupon,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    json['name'] = json['name'] ?? json['name_ar'];
    json['description'] = json['description'] ?? json['description_ar'];

    return _$CartModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CartModelToJson(this);
}
