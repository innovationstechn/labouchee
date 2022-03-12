import 'package:json_annotation/json_annotation.dart';
import 'package:labouchee/app/locator.dart';
import 'package:labouchee/services/language_service.dart';

part 'notification_content.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class NotificationContentModel {
  final int? orderId;
  final String? link, message, messageAr;

  NotificationContentModel({
    this.orderId,
    this.link,
    this.message,
    this.messageAr,
  });

  factory NotificationContentModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationContentModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationContentModelToJson(this);
}
