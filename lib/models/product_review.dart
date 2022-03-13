import 'package:json_annotation/json_annotation.dart';

part 'product_review.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class ProductReviewModel {
  final int? id;
  final String? name,rating, review, avatar, userId;
  final DateTime? createdAt;

  ProductReviewModel({
    this.id,
    this.name,
    this.rating,
    this.review,
    this.avatar,
    this.userId,
    this.createdAt,
  });

  factory ProductReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ProductReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductReviewModelToJson(this);
}
