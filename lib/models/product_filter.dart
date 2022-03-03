import 'package:json_annotation/json_annotation.dart';

part 'product_filter.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class ProductFilterModel {
  final int? page, min, max, categoryId;
  final String? sort;
  @JsonKey(name: 'q')
  final String? query;
  @JsonKey(fromJson: _boolFromInt, toJson: _boolToInt)
  final bool? mostViewed, featured, hotSale;


  ProductFilterModel({
    this.page,
    this.min,
    this.max,
    this.sort,
    this.query,
    this.mostViewed,
    this.featured,
    this.hotSale,
    this.categoryId,
  });


  factory ProductFilterModel.fromJson(Map<String, dynamic> json) =>
      _$ProductFilterModelFromJson(json);

  static int? _boolToInt(bool? b) => b == null ? null : b ? 1 : 0;
  static bool? _boolFromInt(int? b) => b == null ? null : b == 1;

  Map<String, dynamic> toJson() => _$ProductFilterModelToJson(this);
}
