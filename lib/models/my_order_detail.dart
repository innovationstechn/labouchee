import 'package:json_annotation/json_annotation.dart';
import 'package:labouchee/models/cart_item.dart';
import 'package:labouchee/models/coupon.dart';
import 'package:labouchee/models/shipping_info.dart';

part 'my_order_detail.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MyOrderDetailModel {
  final int? id;
  @JsonKey(name: 'productsCount')
  final int? productsCount;

  @JsonKey(name: 'orderTotalAmount')
  final double? orderTotalAmount;

  final List<CartItemModel>? orderItems;

  final ShippingInfoModel? shipping;

  final CouponModel? couponDetails;

  final MyOrderUserInputDetailModel? orderDetails;

  final String? userId,
      paymentMethod,
      paypalResponse,
      paymentStatus,
      orderStatus,
      shippingAmount,
      discountAmount,
      couponAmount,
      branchId,
      driverId,
      customerFeedback,
      rating,
      isCancelled,
      cancelledBy,
      cancellationReason,
      deletedAt,
      createdTime;

  MyOrderDetailModel({
    this.id,
    this.productsCount,
    this.orderTotalAmount,
    this.orderItems,
    this.shipping,
    this.couponDetails,
    this.orderDetails,
    this.userId,
    this.paymentMethod,
    this.paypalResponse,
    this.paymentStatus,
    this.orderStatus,
    this.shippingAmount,
    this.discountAmount,
    this.couponAmount,
    this.branchId,
    this.driverId,
    this.customerFeedback,
    this.rating,
    this.isCancelled,
    this.cancelledBy,
    this.cancellationReason,
    this.deletedAt,
    this.createdTime,
  });

  factory MyOrderDetailModel.fromJson(Map<String, dynamic> json) =>
      _$MyOrderDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyOrderDetailModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class MyOrderUserInputDetailModel {
  final String? name, email, orderNote, bookingDate;
  final List<String>? address, phone;

  MyOrderUserInputDetailModel({
    this.name,
    this.email,
    this.orderNote,
    this.bookingDate,
    this.address,
    this.phone,
  });

  factory MyOrderUserInputDetailModel.fromJson(Map<String, dynamic> json) =>
      _$MyOrderUserInputDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyOrderUserInputDetailModelToJson(this);
}
