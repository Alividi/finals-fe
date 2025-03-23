import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:finals_fe/core/provider/user_manager_provider.dart';
import 'package:finals_fe/features/forgot_pw/pages/forgot_password_page.dart';
import 'package:finals_fe/features/login/pages/login_page.dart';
import 'package:finals_fe/features/main/pages/main_page.dart';
import 'package:finals_fe/features/registration/pages/registration_page.dart';
import 'package:finals_fe/features/splashscreen/splashscreen.dart';

import 'router_name.dart';

part 'routers.g.dart';

@Riverpod(keepAlive: true)
Raw<GoRouter> router(RouterRef ref) {
  return GoRouter(
    initialLocation: RouteName.splashscreen,
    debugLogDiagnostics: false,
    routes: [
      GoRoute(
        path: '/splashscreen',
        name: RouteName.splashscreen,
        builder: (context, state) => const Splashscreen(),
        redirect: (context, state) async {
          final user = await ref.watch(userManagerProvider.future);
          final auth = await user.hasUser();
          if (auth == true) {
            return RouteName.main;
          }
          return RouteName.splashscreen;
        },
      ),
      GoRoute(
        path: '/',
        name: RouteName.main,
        builder: (context, state) => const MainPage(id: 0),
      ),
      GoRoute(
        path: '/login',
        name: RouteName.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/forgot-password',
        name: RouteName.forgotPassword,
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: '/register',
        name: RouteName.register,
        builder: (context, state) => const RegistrationPage(),
      ),
    ],
  );
}
