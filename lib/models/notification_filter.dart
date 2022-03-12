import 'package:json_annotation/json_annotation.dart';

part 'notification_filter.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class NotificationFilterModel {
  final int? seen;
  final String? type;

  NotificationFilterModel({
    this.seen,
    this.type,
  });

  factory NotificationFilterModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationFilterModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationFilterModelToJson(this);
}
