import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CategoryModel {
  final int? id, productsCount;
  final String? photo, name;

  CategoryModel({
    this.id,
    this.productsCount,
    this.photo,
    this.name,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
