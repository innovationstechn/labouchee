import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

part 'update_profile.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UpdateProfileModel {
  final String? name;
  @JsonKey(ignore: true)
  final File? avatar;
  @JsonKey(ignore: true)
  final String? contactNo1, contactNo2, address1, address2;

  UpdateProfileModel({
    this.name,
    this.avatar,
    this.contactNo1,
    this.contactNo2,
    this.address1,
    this.address2,
  });

  factory UpdateProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileModelFromJson(json);

  Map<String, dynamic> toJson() {
    final map = _$UpdateProfileModelToJson(this);

    if(address2 != null) {
      map['address[]'] = [address1, address2];
    } else {
      map['address[]'] = [address1];
    }


    map['contact_no'] = contactNo1;

    return map;
  }
}
