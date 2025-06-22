import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:finals_fe/core/controllers/auth_controller.dart';
import 'package:finals_fe/core/controllers/fcm_token_provider.dart';
import 'package:finals_fe/core/domain/entities/token.dart';
import 'package:finals_fe/core/provider/token_manager_provider.dart';
import 'package:finals_fe/core/provider/user_manager_provider.dart';
import 'package:finals_fe/features/main/controllers/selected_index_provider.dart';
import 'package:finals_fe/helpers/header/user_agent_helper.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

part 'dio_provider.g.dart';

final baseUrl = dotenv.env['BASE_URL'];
Completer<void>? _refreshTokenCompleter;

String _getBaseUrl(String path) {
  return baseUrl!;
}

@riverpod
Dio dio(Ref ref) {
  final dio = Dio();
  dio.options.connectTimeout = const Duration(seconds: 120);
  dio.options.receiveTimeout = const Duration(seconds: 120);
  dio.options.validateStatus = (status) {
    return status != null && status >= 200 && status < 300;
  };

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Set the base URL dynamically
        options.baseUrl = _getBaseUrl(options.path);

        final userManager = await ref.read(userManagerProvider.future);

        TokenManager tokenManager = await ref.watch(tokenManagerProvider.future);
        final authToken = await tokenManager.getToken();
        log('Token: $authToken');

        if ((authToken != null && _getBaseUrl(options.path) == baseUrl) ||
            (authToken != null &&
                await userManager.hasUser() &&
                options.path.startsWith('products/'))) {
          options.headers['Authorization'] = 'Bearer $authToken';
        }

        // Get the User-Agent
        String userAgent = await UserAgentHelper.initUserAgentState();
        options.headers['User-Agent'] = userAgent;

        return handler.next(options);
      },
      onError: (DioException e, handler) async {
        final userManager = await ref.read(userManagerProvider.future);

        if (await userManager.hasUser() && e.response?.statusCode == 401) {
          final tokenManager = await ref.watch(tokenManagerProvider.future);
          final refreshToken = await tokenManager.getRefreshToken();

          if (refreshToken != null) {
            // If a refresh is already in progress, wait for it
            if (_refreshTokenCompleter != null) {
              await _refreshTokenCompleter!.future;
            } else {
              // Otherwise, create the lock
              _refreshTokenCompleter = Completer<void>();
              try {
                final refreshDio = Dio();
                final refreshResponse = await refreshDio.post(
                  '${baseUrl}refresh-token',
                  data: {'refresh_token': refreshToken},
                );

                if (refreshResponse.statusCode == 200) {
                  final newToken = Token.fromJson(refreshResponse.data['data']);
                  final newRefreshToken = Token.fromJson(refreshResponse.data['data']);

                  await tokenManager.saveToken(newToken.accessToken);
                  await tokenManager.saveRefreshToken(newRefreshToken.refreshToken);

                  // Unlock others
                  _refreshTokenCompleter?.complete();
                } else {
                  throw Exception('Refresh failed');
                }
              } catch (err) {
                _refreshTokenCompleter?.complete(); // Ensure we unblock waiters
                final fcmToken = await ref.watch(saveFCMTokenProvider.future);
                final user = await userManager.getUser();
                final userId = user?.userId ?? 0;
                log('FCMTOKEN logout : $fcmToken');
                log('User logout : ${user?.toJson()}');
                log('UserId logout : ${user?.userId}');
                ref.read(
                    logoutProvider(fcmToken, userId).future); // Logout the user clear fcm token
                ref.read(selectedIndexNavBar.notifier).state = 0;
                return handler.reject(e);
              } finally {
                _refreshTokenCompleter = null; // Reset the lock
              }
            }

            // Retry the original request with the new token
            final newAccessToken = await tokenManager.getToken();
            e.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
            final clonedRequest = await dio.request(
              e.requestOptions.path,
              options: Options(
                method: e.requestOptions.method,
                headers: e.requestOptions.headers,
              ),
              data: e.requestOptions.data,
              queryParameters: e.requestOptions.queryParameters,
            );
            return handler.resolve(clonedRequest);
          }
        }

        return handler.next(e);
      },
    ),
  );

  if (!kReleaseMode) {
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));
  }

  return dio;
}
