import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';

part 'banner.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class BannerModel {
  final String? photo, url, bannerType;
  final String? headingOneAr, headingTwoAr, headingThreeAr;
  final String? headingOne, headingTwo, headingThree;
  @JsonKey(fromJson: _doubleFromString, toJson: _doubleToString)
  final double? fontSizeOne, fontSizeTwo, fontSizeThree;
  @JsonKey(fromJson: _colorFromString, toJson: _colorToString)
  final Color? textColor;

  BannerModel({
    required this.photo,
    required this.url,
    required this.bannerType,
    required this.headingOne,
    required this.headingTwo,
    required this.headingThree,
    required this.headingOneAr,
    required this.headingTwoAr,
    required this.headingThreeAr,
    required this.fontSizeOne,
    required this.fontSizeTwo,
    required this.fontSizeThree,
    required this.textColor,
  });

  static double? _doubleFromString(String? str) =>
      str == null ? null : double.tryParse(str);

  static String? _doubleToString(double? dbl) => dbl?.toString();

  static Color? _colorFromString(String? str) {
    if (str == null) return null;

    bool startsWithHash = str.startsWith("#");

    var color = int.tryParse(
        str.substring(startsWithHash ? 1 : 0, startsWithHash ? 7 : 6),
        radix: 16);

    if (color == null) return null;

    color += 0xFF000000;

    return Color(color);
  }

  static String? _colorToString(Color? color) => color?.toString();

  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);

  Map<String, dynamic> toJson() => _$BannerModelToJson(this);
}
