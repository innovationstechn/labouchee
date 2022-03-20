import 'package:json_annotation/json_annotation.dart';

part 'inquiry.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class InquiryModel {
  final String? subject, message;

  InquiryModel({
    this.subject,
    this.message,
  });

  factory InquiryModel.fromJson(Map<String, dynamic> json) =>
      _$InquiryModelFromJson(json);

  Map<String, dynamic> toJson() => _$InquiryModelToJson(this);
}
