import 'package:json_annotation/json_annotation.dart';

part 'banner_filter.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class BannerFilterModel {
  final String? type;

  BannerFilterModel({
    this.type,
  });


  factory BannerFilterModel.fromJson(Map<String, dynamic> json) =>
      _$BannerFilterModelFromJson(json);

  Map<String, dynamic> toJson() => _$BannerFilterModelToJson(this);
}
