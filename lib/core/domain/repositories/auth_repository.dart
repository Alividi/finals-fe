import 'package:dartz/dartz.dart';
import 'package:finals_fe/core/domain/entities/auth_params.dart';
import 'package:finals_fe/core/domain/entities/token.dart';
import 'package:finals_fe/core/domain/entities/user_model.dart';

abstract class AuthRepository {
  Future<Either<String, Token>> login({required LoginParams params});
  Future<Either<String, String>> logout(String fcmToken, int userId);
  Future<Either<String, UserModel>> getUser();
}
