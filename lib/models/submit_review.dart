import 'package:json_annotation/json_annotation.dart';

part 'submit_review.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SubmitReviewModel {
  int? productId, rating;
  final String? review;

  SubmitReviewModel({
    this.productId,
    this.rating,
    this.review,
  });

  factory SubmitReviewModel.fromJson(Map<String, dynamic> json) =>
      _$SubmitReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitReviewModelToJson(this);
}
