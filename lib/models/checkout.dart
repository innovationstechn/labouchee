import 'package:json_annotation/json_annotation.dart';

part 'checkout.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CheckoutModel {
  final String? name, email, contactNo, paymentMethod, branch, notes;
  @JsonKey(name: 'address[]')
  final String? address1;
  @JsonKey(ignore: true)
  final String? address2;

  CheckoutModel({
    this.name,
    this.email,
    this.address1,
    this.address2,
    this.contactNo,
    this.paymentMethod,
    this.branch,
    this.notes,
  });

  factory CheckoutModel.fromJson(Map<String, dynamic> json) =>
      _$CheckoutModelFromJson(json);
  Map<String, dynamic> toJson() => _$CheckoutModelToJson(this);
}
