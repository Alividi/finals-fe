import 'package:dartz/dartz.dart';
import 'package:finals_fe/core/domain/entities/user_model.dart';
import 'package:finals_fe/core/domain/repository/authentication_repository.dart';
import 'package:finals_fe/utils/usecase/usecase.dart';

class GetUser implements UseCase<UserModel, void> {
  final AuthenticationRepository authenticationRepository;

  GetUser({required this.authenticationRepository});

  @override
  Future<Either<String, UserModel>> call(void params) async {
    return authenticationRepository.getUser();
  }
}
