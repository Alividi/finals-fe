import 'package:dartz/dartz.dart';
import 'package:finals_fe/core/domain/entities/user_model.dart';

abstract class AuthenticationRepository {
  Future<Either<String, String>> login({
    required String username,
    required String password,
  });
  Future<Either<String, String>> logout();
  Future<Either<String, UserModel>> getUser();
}
