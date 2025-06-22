import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:finals_fe/core/provider/dio_provider.dart';
import 'package:finals_fe/features/setting/domain/entities/user_status_model.dart';
import 'package:finals_fe/features/setting/domain/repositories/user_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_repository_impl.g.dart';

@riverpod
UserRepository userRepository(Ref ref) {
  final httpclient = ref.watch(dioProvider);
  return UserRepositoryImpl(httpclient: httpclient);
}

class UserRepositoryImpl implements UserRepository {
  final Dio httpclient;

  UserRepositoryImpl({required this.httpclient});

  @override
  Future<Either<String, UserStatusModel>> getUserStatus() async {
    try {
      final response = await httpclient.get(
        'user-status',
      );
      if (response.statusCode == 200) {
        final userProfile = UserStatusModel.fromJson(response.data['data']);
        return Right(userProfile);
      } else {
        throw Exception('Gagal mendapatkan data user status');
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'] ?? e.message;
      throw Exception(errorMessage);
    }
  }
}
