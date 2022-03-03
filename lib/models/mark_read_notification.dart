import 'package:json_annotation/json_annotation.dart';

part 'mark_read_notification.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MarkReadNotificationModel {
  List<int>? notification;

  MarkReadNotificationModel({
    this.notification,
  });

  factory MarkReadNotificationModel.fromJson(Map<String, dynamic> json) =>
      _$MarkReadNotificationModelFromJson(json);
  Map<String, dynamic> toJson() => _$MarkReadNotificationModelToJson(this);
}
