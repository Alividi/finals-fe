import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'user_status_model.freezed.dart';
part 'user_status_model.g.dart';

UserStatusModel userStatusModelFromJson(String str) => UserStatusModel.fromJson(json.decode(str));

String userStatusModelToJson(UserStatusModel data) => json.encode(data.toJson());

@freezed
abstract class UserStatusModel with _$UserStatusModel {
  const factory UserStatusModel({
    @JsonKey(name: "notification_count") int? notificationCount,
  }) = _UserStatusModel;

  factory UserStatusModel.fromJson(Map<String, dynamic> json) => _$UserStatusModelFromJson(json);
}
