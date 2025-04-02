import 'package:finals_fe/admin/main/pages/admin_main_page.dart';
import 'package:finals_fe/admin/ticket/pages/admin_ticket_detail_page.dart';
import 'package:finals_fe/features/order/pages/order_detail_page.dart';
import 'package:finals_fe/features/product/pages/product_detail_page.dart';
import 'package:finals_fe/features/service/pages/service_detail_page.dart';
import 'package:finals_fe/features/service/pages/service_map_page.dart';
import 'package:finals_fe/technician/main/pages/technician_main_page.dart';
import 'package:finals_fe/technician/ticket/pages/technician_ticket_detail_page.dart';
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
      //Customer Routes
      GoRoute(
        path: '/main',
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
      GoRoute(
        path: '/service-detail',
        name: RouteName.serviceDetail,
        builder: (context, state) => const ServiceDetailPage(),
      ),
      GoRoute(
        path: '/service-map',
        name: RouteName.serviceMap,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final latitude = extra['latitude'] as double;
          final longitude = extra['longitude'] as double;
          final snKit = extra['snKit'] as String;
          final mNodelinkId = extra['mNodelinkId'] as int;

          return ServiceMapPage(
            initialLatitude: latitude,
            initialLongitude: longitude,
            snKit: snKit,
            mNodelinkId: mNodelinkId,
          );
        },
      ),
      GoRoute(
        path: '/product-detail',
        name: RouteName.productDetail,
        builder: (context, state) => const ProductDetailPage(),
      ),
      GoRoute(
        path: '/order-detail',
        name: RouteName.orderDetail,
        builder: (context, state) => const OrderDetailPage(),
      ),
      //Admin Routes
      GoRoute(
        path: '/admin-main',
        name: RouteName.adminMain,
        builder: (context, state) => const AdminMainPage(id: 0),
      ),
      GoRoute(
        path: '/admin-ticket-detail',
        name: RouteName.adminTicketDetail,
        builder: (context, state) => const AdminTicketDetailPage(),
      ),
      //Technician Routes
      GoRoute(
        path: '/technician-main',
        name: RouteName.technicianMain,
        builder: (context, state) => const TechnicianMainPage(id: 0),
      ),
      GoRoute(
        path: '/technician-ticket-detail',
        name: RouteName.technicianTicketDetail,
        builder: (context, state) => const TechnicianTicketDetailPage(),
      ),
    ],
  );
}
