import 'package:json_annotation/json_annotation.dart';

import 'cart.dart';

part 'cart_detail.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CartDetailModel {
  @JsonKey(name: 'cart_items')
  final CartModel? cart;
  final CartDetailInfoModel? cartInfo;

  CartDetailModel({
    this.cart,
    this.cartInfo,
  });

  factory CartDetailModel.fromJson(Map<String, dynamic> json) {
    return _$CartDetailModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CartDetailModelToJson(this);
}

@JsonSerializable()
class CartDetailInfoModel {
  final int? totalItems;
  final double? totalPrice, discountAmount, shipping;
  final String? message;

  CartDetailInfoModel({
    this.totalPrice,
    this.totalItems,
    this.discountAmount,
    this.shipping,
    this.message,
  });

  factory CartDetailInfoModel.fromJson(Map<String, dynamic> json) {
    return _$CartDetailInfoModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CartDetailInfoModelToJson(this);
}
