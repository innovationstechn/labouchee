import 'package:json_annotation/json_annotation.dart';

part 'place_order.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class PlaceOrderModel {
  String? name, email, orderNote, bookingTime, bookingDate, telr;
  int? city, branch;
  PaymentMethod? paymentMethod;

  @JsonKey(ignore: true)
  String? addr1, addr2;
  @JsonKey(ignore: true)
  String? phone, phone2;

  PlaceOrderModel({
    this.name,
    this.phone,
    this.city,
    this.email,
    this.paymentMethod,
    this.branch,
    this.addr1,
    this.addr2,
    this.orderNote,
    this.bookingDate,
    this.bookingTime,
    this.telr,
  });

  factory PlaceOrderModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceOrderModelFromJson(json);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = _$PlaceOrderModelToJson(this);

    if (addr2 != null) {
      map['address'] = [addr1, addr2];
    } else {
      map['address'] = [addr1];
    }

    if (phone2 != null) {
      map['phone'] = [phone, phone2];
    } else {
      map['phone'] = [phone];
    }

    return map;
  }
}

enum PaymentMethod {
  @JsonValue('cash_on_delivery')
  cashOnDelivery,
  @JsonValue('telr')
  digital,
  @JsonValue('pick_from_branch')
  pickup,
  mada
}

extension Stringify on PaymentMethod {
  String toJson() {
    switch (this) {
      case PaymentMethod.cashOnDelivery:
        return 'cash_on_delivery';
      case PaymentMethod.digital:
        return 'credit';
      case PaymentMethod.pickup:
        return 'pick_from_branch';
      case PaymentMethod.mada:
        return 'mada';
    }
  }

  // Not needed.
  String fromJson() {
    return '';
  }
}
