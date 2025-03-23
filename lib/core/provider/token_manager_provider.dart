import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:finals_fe/core/provider/shared_preference_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'token_manager_provider.g.dart';

@riverpod
FutureOr<TokenManager> tokenManager(TokenManagerRef ref) async {
  final sharedPreferences = await ref.watch(sharedPreferenceProvider.future);
  return TokenManager(
    sharedPreferences: sharedPreferences,
  );
}

class TokenManager {
  final SharedPreferences sharedPreferences;

  TokenManager({required this.sharedPreferences});

  Future<void> saveToken(String token) async {
    await sharedPreferences.setString('token', token);
  }

  Future<String?> getToken() async {
    return sharedPreferences.getString('token');
  }

  Future<void> removeToken() async {
    await sharedPreferences.remove('token');
  }

  Future<void> saveRefreshToken(String token) async {
    await sharedPreferences.setString('refreshToken', token);
  }

  Future<String?> getRefreshToken() async {
    return sharedPreferences.getString('refreshToken');
  }

  Future<void> removeRefreshToken() async {
    await sharedPreferences.remove('refreshToken');
  }

  Future<bool> isLogin() async {
    final token = await getToken();
    return token != null;
  }
}
