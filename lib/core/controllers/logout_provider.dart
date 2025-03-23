import 'package:finals_fe/core/controllers/authentication_impl_provider.dart';
import 'package:finals_fe/core/domain/usecases/logout.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'logout_provider.g.dart';

@riverpod
Logout logout(LogoutRef ref) {
  return Logout(
    authenticationRepository: ref.watch(authenticationRepositoryProvider),
  );
}
