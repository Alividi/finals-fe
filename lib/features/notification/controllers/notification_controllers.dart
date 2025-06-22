import 'package:finals_fe/features/notification/data/notification_repository_impl.dart';
import 'package:finals_fe/features/notification/domain/entities/notifications_model.dart';
import 'package:finals_fe/features/notification/domain/entities/notifications_params.dart';
import 'package:finals_fe/features/setting/controllers/user_controllers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_controllers.g.dart';

@riverpod
Future<String> readNotification(Ref ref, int notificationId) async {
  final repository = ref.watch(notificationRepositoryProvider);
  ref.invalidate(getNotificationsProvider);
  ref.invalidate(userStatusControllerProvider);
  final readNotification = await repository.markAsRead(notificationId);
  return readNotification.fold((error) => throw Exception(error), (data) => data);
}

@riverpod
Future<String> readAllNotifications(Ref ref) async {
  final repository = ref.watch(notificationRepositoryProvider);
  ref.invalidate(getNotificationsProvider);
  ref.invalidate(userStatusControllerProvider);
  final readAllNotifications = await repository.markAllAsRead();
  return readAllNotifications.fold((error) => throw Exception(error), (data) => data);
}

@riverpod
Future<NotificationsModel> getNotifications(Ref ref, NotificationsParams params) async {
  final repository = ref.watch(notificationRepositoryProvider);

  final notifications = await repository.getNotifications(params);
  return notifications.fold((error) => throw Exception(error), (data) => data);
}
