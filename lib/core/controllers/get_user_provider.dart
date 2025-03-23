import 'package:finals_fe/core/controllers/authentication_impl_provider.dart';
import 'package:finals_fe/core/domain/usecases/get_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_user_provider.g.dart';

@riverpod
GetUser getUser(GetUserRef ref) {
  return GetUser(authenticationRepository: ref.watch(authenticationRepositoryProvider));
}
