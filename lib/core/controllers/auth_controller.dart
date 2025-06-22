import 'package:finals_fe/core/data/auth_repository_impl.dart';
import 'package:finals_fe/core/domain/entities/auth_params.dart';
import 'package:finals_fe/core/provider/token_manager_provider.dart';
import 'package:finals_fe/core/provider/user_manager_provider.dart';
import 'package:finals_fe/routers/router_name.dart';
import 'package:finals_fe/routers/routers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@riverpod
Future<void> login(
  LoginRef ref,
  LoginParams params,
) async {
  final authRepository = ref.read(authRepositoryProvider);
  final tokenManager = await ref.watch(tokenManagerProvider.future);
  final userManager = await ref.watch(userManagerProvider.future);

  final tokenResult = await authRepository.login(params: params);
  await tokenResult.fold(
    (error) async => throw Exception(error),
    (token) async {
      // Save tokens to shared preferences
      await tokenManager.saveToken(token.accessToken);
      await tokenManager.saveRefreshToken(token.refreshToken);

      // Fetch and save user data
      final userResult = await authRepository.getUser();
      await userResult.fold(
        (error) async => throw Exception(error),
        (user) async {
          await userManager.saveUser(user);
          ref.read(routerProvider).goNamed(RouteName.splashscreen);
        },
      );
    },
  );
}

@riverpod
Future<void> logout(LogoutRef ref, String fcmToken, int userId) async {
  final authRepository = ref.read(authRepositoryProvider);
  final tokenManager = await ref.watch(tokenManagerProvider.future);
  final userManager = await ref.watch(userManagerProvider.future);

  final result = await authRepository.logout(fcmToken, userId);
  await result.fold(
    (error) => throw Exception(error),
    (message) async {
      // Clear tokens and user data from shared preferences
      await tokenManager.removeToken();
      await tokenManager.removeRefreshToken();
      await userManager.removeUser();

      ref.read(routerProvider).pushReplacementNamed(RouteName.login);
    },
  );
}
