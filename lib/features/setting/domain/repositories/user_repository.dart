import 'package:dartz/dartz.dart';
import 'package:finals_fe/features/setting/domain/entities/user_status_model.dart';

abstract class UserRepository {
  Future<Either<String, UserStatusModel>> getUserStatus();
}
