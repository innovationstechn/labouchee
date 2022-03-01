import 'package:json_annotation/json_annotation.dart';

part 'cart_item.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CartItemModel {
  @JsonKey(name: 'product_id')
  final int? id;
  @JsonKey(name: 'totalQuantity')
  final int? totalQuantity;
  final String? title, image;
  @JsonKey(name: 'totalAmount')
  final double? totalAmount;
  final double? discount;
  final List<CartItemSizeModel>? size;

  CartItemModel({
    this.id,
    this.totalQuantity,
    this.title,
    this.image,
    this.totalAmount,
    this.discount,
    this.size,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    json['name'] = json['name'] ?? json['name_ar'];
    json['description'] = json['description'] ?? json['description_ar'];

    return _$CartItemModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CartItemModelToJson(this);
}

@JsonSerializable()
class CartItemSizeModel {
  final String? type;
  final double? price;
  final int? quantity;

  CartItemSizeModel({
    this.type,
    this.price,
    this.quantity,
  });

  factory CartItemSizeModel.fromJson(Map<String, dynamic> json) {
    json['name'] = json['name'] ?? json['name_ar'];
    json['description'] = json['description'] ?? json['description_ar'];

    return _$CartItemSizeModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CartItemSizeModelToJson(this);
}