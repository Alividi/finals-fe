// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:finals_fe/core/domain/repository/authentication_repository.dart';
import 'package:finals_fe/utils/usecase/usecase.dart';

class Login implements UseCase<String, LoginParams> {
  final AuthenticationRepository authenticationRepository;

  Login({required this.authenticationRepository});

  @override
  Future<Either<String, String>> call(LoginParams params) async {
    return authenticationRepository.login(username: params.username, password: params.password);
  }
}

class LoginParams {
  final String username;
  final String password;

  LoginParams({
    required this.username,
    required this.password,
  });
}
