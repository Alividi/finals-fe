import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:finals_fe/core/domain/entities/auth_params.dart';
import 'package:finals_fe/core/domain/entities/token.dart';
import 'package:finals_fe/core/domain/entities/user_model.dart';
import 'package:finals_fe/core/domain/repositories/auth_repository.dart';
import 'package:finals_fe/core/provider/dio_provider.dart';
import 'package:finals_fe/utils/errors/dio_error.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository_impl.g.dart';

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  final httpClient = ref.watch(dioProvider);
  return AuthRepositoryImpl(httpClient: httpClient);
}

class AuthRepositoryImpl implements AuthRepository {
  final Dio httpClient;

  AuthRepositoryImpl({required this.httpClient});

  @override
  Future<Either<String, Token>> login({required LoginParams params}) async {
    try {
      final response = await httpClient.post(
        'login',
        data: {
          "username": params.input,
          "password": params.password,
          "fcm_token": params.fcmToken,
        },
      );
      if (response.statusCode == 200) {
        final token = Token.fromJson(response.data['data']);
        log("Access Token: ${token.accessToken}");
        log("Refresh Token: ${token.refreshToken}");
        return Right(token);
      } else if (response.statusCode == 401) {
        return Left(response.data['error']);
      } else {
        return const Left('Verification login failed');
      }
    } on DioException catch (e) {
      final error = await DioErrorHandler.handleError(e);
      return Left(error);
    } catch (e) {
      return Left('Error: $e');
    }
  }

  @override
  Future<Either<String, UserModel>> getUser() async {
    try {
      final response = await httpClient.get(
        'current-user',
      );
      if (response.statusCode == 200) {
        final user = response.data['data'];
        return Right(
          UserModel.fromJson(user),
        );
      } else if (response.statusCode == 401) {
        return Left(response.data['message']);
      } else {
        return const Left('Gagal mendapatkan data user');
      }
    } on DioException catch (e) {
      final error = await DioErrorHandler.handleError(e);
      return Left(error);
    } catch (e) {
      return Left('Error: $e');
    }
  }

  @override
  Future<Either<String, String>> logout(String fcmToken, int userId) async {
    try {
      final response = await httpClient.post(
        'logout',
        data: {
          "fcm_token": fcmToken,
          "user_id": userId,
        },
      );
      if (response.statusCode == 200) {
        return Right(response.data['message']);
      } else if (response.statusCode == 401) {
        return Left(response.data['message']);
      } else {
        return const Left('Something went wrong');
      }
    } on DioException catch (e) {
      final error = await DioErrorHandler.handleError(e);
      return Left(error);
    } catch (e) {
      return Left('Error: $e');
    }
  }
}
