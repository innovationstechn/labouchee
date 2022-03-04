import 'package:json_annotation/json_annotation.dart';

part 'branch.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class BranchModel {
  final int id;
  final String? name, address, timing, contactNo, whatsapp, email, googleMapUrl;
  final DateTime? createdAt, updatedAt;

  BranchModel({
    required this.id,
    this.name,
    this.address,
    this.timing,
    this.contactNo,
    this.whatsapp,
    this.email,
    this.googleMapUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) =>
      _$BranchModelFromJson(json);
  Map<String, dynamic> toJson() => _$BranchModelToJson(this);
}
