import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'notifications_model.freezed.dart';
part 'notifications_model.g.dart';

NotificationsModel notificationsModelFromJson(String str) =>
    NotificationsModel.fromJson(json.decode(str));

String notificationsModelToJson(NotificationsModel data) => json.encode(data.toJson());

@freezed
abstract class NotificationsModel with _$NotificationsModel {
  const factory NotificationsModel({
    @JsonKey(name: "notifications") List<Notification>? notifications,
    @JsonKey(name: "meta") Meta? meta,
  }) = _NotificationsModel;

  factory NotificationsModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationsModelFromJson(json);
}

@freezed
abstract class Meta with _$Meta {
  const factory Meta({
    @JsonKey(name: "page") int? page,
    @JsonKey(name: "page_size") int? pageSize,
    @JsonKey(name: "total") int? total,
    @JsonKey(name: "total_page") int? totalPage,
    @JsonKey(name: "total_data") int? totalData,
  }) = _Meta;

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
}

@freezed
abstract class Notification with _$Notification {
  const factory Notification({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "user_id") int? userId,
    @JsonKey(name: "is_read") bool? isRead,
    @JsonKey(name: "judul") String? judul,
    @JsonKey(name: "type") String? type,
    @JsonKey(name: "deskripsi") String? deskripsi,
    @JsonKey(name: "created_at") DateTime? createdAt,
    @JsonKey(name: "updated_at") DateTime? updatedAt,
  }) = _Notification;

  factory Notification.fromJson(Map<String, dynamic> json) => _$NotificationFromJson(json);
}
