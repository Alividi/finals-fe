import 'package:finals_fe/core/controllers/authentication_impl_provider.dart';
import 'package:finals_fe/core/domain/usecases/login.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_provider.g.dart';

@riverpod
Login login(LoginRef ref) {
  return Login(authenticationRepository: ref.read(authenticationRepositoryProvider));
}
