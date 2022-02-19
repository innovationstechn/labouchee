import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductModel {
  final int? id;
  final String? name, description;
  final List<String>? images;

  @JsonKey(fromJson: _doubleFromString, toJson: _doubleToString)
  final double? discount, price,
      productRating;

  @JsonKey(name: 'price_sm', fromJson: _doubleFromString, toJson: _doubleToString)
  final double? priceSmall;

  @JsonKey(name: 'price_md', fromJson: _doubleFromString, toJson: _doubleToString)
  final double? priceMedium;

  @JsonKey(name: 'price_lg', fromJson: _doubleFromString, toJson: _doubleToString)
  final double? priceLarge;

  ProductModel({
    this.id,
    this.name,
    this.description,
    this.images,
    this.discount,
    this.price,
    this.priceSmall,
    this.priceMedium,
    this.priceLarge,
    this.productRating,
  });

  static double? _doubleFromString(String? str) =>
      str == null ? null : double.tryParse(str);

  static String? _doubleToString(double? dbl) => dbl?.toString();

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    json['name'] = json['name'] ?? json['name_ar'];
    json['description'] = json['description'] ?? json['description_ar'];

    return _$ProductModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
