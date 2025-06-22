import 'package:dartz/dartz.dart';
import 'package:finals_fe/features/notification/domain/entities/notifications_model.dart';
import 'package:finals_fe/features/notification/domain/entities/notifications_params.dart';

abstract class NotificationRepository {
  Future<Either<String, NotificationsModel>> getNotifications(NotificationsParams params);
  Future<Either<String, String>> markAsRead(int notificationId);
  Future<Either<String, String>> markAllAsRead();
}
