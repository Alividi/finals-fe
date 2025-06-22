import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:finals_fe/core/provider/dio_provider.dart';
import 'package:finals_fe/features/notification/domain/entities/notifications_model.dart';
import 'package:finals_fe/features/notification/domain/entities/notifications_params.dart';
import 'package:finals_fe/features/notification/domain/repositories/notification_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_repository_impl.g.dart';

@riverpod
NotificationRepository notificationRepository(Ref ref) {
  final httpClient = ref.watch(dioProvider);
  return NotificationRepositoryImpl(httpClient: httpClient);
}

class NotificationRepositoryImpl implements NotificationRepository {
  final Dio httpClient;

  NotificationRepositoryImpl({required this.httpClient});

  @override
  Future<Either<String, NotificationsModel>> getNotifications(NotificationsParams params) async {
    try {
      final response = await httpClient.get(
        'notifications',
        queryParameters: {
          'page': params.page,
          'page_size': params.pageSize,
          if (params.type != null) 'type': params.type,
        },
      );

      if (response.statusCode == 200) {
        final notifications = NotificationsModel.fromJson(response.data['data']);
        return Right(notifications);
      } else if (response.data?['message'] != null) {
        return Left(response.data['message']);
      } else {
        throw Exception('Failed to get notifications');
      }
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data?['message'] ?? e.message ?? 'An unexpected error occurred';
      return Left(errorMessage);
    }
  }

  @override
  Future<Either<String, String>> markAsRead(int notificationId) async {
    try {
      final response = await httpClient.post(
        'notifications/read/$notificationId',
      );

      if (response.statusCode == 200) {
        return const Right('Success');
      } else if (response.data['message'] != null) {
        return Left(response.data['message']);
      } else {
        throw Exception('Failed to read notification');
      }
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message'] ?? e.message ?? 'An unexpected error occurred';
      return Left(errorMessage);
    }
  }

  @override
  Future<Either<String, String>> markAllAsRead() async {
    try {
      final response = await httpClient.post(
        'notifications/read',
      );

      if (response.statusCode == 200) {
        return const Right('Success');
      } else if (response.data['message'] != null) {
        return Left(response.data['message']);
      } else {
        throw Exception('Failed to read all notifications');
      }
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message'] ?? e.message ?? 'An unexpected error occurred';
      return Left(errorMessage);
    }
  }
}
