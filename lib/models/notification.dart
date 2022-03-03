import 'package:json_annotation/json_annotation.dart';
import 'package:labouchee/models/notification_content.dart';

part 'notification.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class NotificationModel {
  final int? id;
  final String? userId, type, photo, name, seen, createdDate, seenDate;
  final NotificationContentModel? notification;

  NotificationModel({
    this.id,
    this.userId,
    this.type,
    this.photo,
    this.name,
    this.seen,
    this.createdDate,
    this.seenDate,
    this.notification,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
