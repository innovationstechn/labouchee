import 'package:json_annotation/json_annotation.dart';

part 'update_profile_error.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UpdateProfileErrorModel {
  final List<String>? name, avatar, contact, address;

  UpdateProfileErrorModel({
    this.name,
    this.avatar,
    this.contact,
    this.address,
  });

  factory UpdateProfileErrorModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileErrorModelToJson(this);
}
