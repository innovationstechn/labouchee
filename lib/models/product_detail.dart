import 'package:json_annotation/json_annotation.dart';
import 'package:labouchee/models/product.dart';

part 'product_detail.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductDetailModel extends ProductModel {
  final String? category;
  final AvailableSizesModel? availableSizes;

  ProductDetailModel({
    this.category,
    this.availableSizes,
    int? id,
    String? name,
    String? description,
    List<String>? images,
    double? discount,
    double? price,
    double? priceSmall,
    double? priceMedium,
    double? priceLarge,
    double? productRating,
  }) : super(
          id: id,
          name: name,
          description: description,
          images: images,
          discount: discount,
          price: price,
          priceSmall: priceSmall,
          priceMedium: priceMedium,
          priceLarge: priceLarge,
          productRating: productRating,
        );

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    json['name'] = json['name'] ?? json['name_ar'];
    json['description'] = json['description'] ?? json['description_ar'];
    json['discount'] = json['discount']?.toString();

    return _$ProductDetailModelFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$ProductDetailModelToJson(this);

  factory ProductDetailModel.fromProductModel(ProductModel model) {
    return ProductDetailModel(
      id: model.id,
      name: model.name,
      description: model.description,
      images: model.images,
      discount: model.discount,
      price: model.price,
      priceSmall: model.priceSmall,
      priceMedium: model.priceMedium,
      priceLarge: model.priceLarge,
      productRating: model.productRating,
    );
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class AvailableSizesModel {
  @JsonKey(name: 'default')
  final String? size;
  @JsonKey(name: 'sm')
  final String? small;
  @JsonKey(name: 'md')
  final String? medium;
  @JsonKey(name: 'lg')
  final String? large;

  AvailableSizesModel({
    this.size,
    this.small,
    this.medium,
    this.large,
  });

  factory AvailableSizesModel.fromJson(Map<String, dynamic> json) {
    return _$AvailableSizesModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AvailableSizesModelToJson(this);
}
