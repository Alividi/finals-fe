import 'package:finals_fe/admin/ba/pages/ba_page.dart';
import 'package:finals_fe/admin/main/pages/admin_main_page.dart';
import 'package:finals_fe/admin/ticket/pages/admin_ticket_detail_page.dart';
import 'package:finals_fe/features/change_pw/pages/change_password_page.dart';
import 'package:finals_fe/features/notification/page/notification_page.dart';
import 'package:finals_fe/features/order/pages/order_detail_page.dart';
import 'package:finals_fe/features/product/pages/product_detail_page.dart';
import 'package:finals_fe/features/service/pages/service_detail_page.dart';
import 'package:finals_fe/features/service/pages/service_map_page.dart';
import 'package:finals_fe/features/troubleshoot/pages/troubleshoot_page.dart';
import 'package:finals_fe/technician/ba/pages/ba_form_page.dart';
import 'package:finals_fe/technician/main/pages/technician_main_page.dart';
import 'package:finals_fe/technician/ticket/pages/technician_ticket_detail_page.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
Raw<GoRouter> router(Ref ref) {
  return GoRouter(
    initialLocation: RouteName.splashscreen,
    debugLogDiagnostics: false,
    routes: [
      GoRoute(
        path: '/splashscreen',
        name: RouteName.splashscreen,
        builder: (context, state) => const Splashscreen(),
        redirect: (context, state) async {
          final userManager = await ref.read(userManagerProvider.future);
          final hasUser = await userManager.hasUser();

          if (hasUser) {
            final user = await userManager.getUser();
            final role = user?.role?.toLowerCase();

            if (role == 'customer') {
              return RouteName.main;
            } else if (role == 'admin') {
              return RouteName.adminMain;
            } else if (role == 'teknisi') {
              return RouteName.technicianMain;
            }
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
        path: '/change-password',
        name: RouteName.changePassword,
        builder: (context, state) => const ChangePasswordPage(),
      ),
      GoRoute(
        path: '/register',
        name: RouteName.register,
        builder: (context, state) => const RegistrationPage(),
      ),
      GoRoute(
        path: '/service-detail',
        name: RouteName.serviceDetail,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final serviceId = extra['serviceId'] as int;
          return ServiceDetailPage(
            serviceId: serviceId,
          );
        },
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
      GoRoute(
        path: '/troubleshoot',
        name: RouteName.troubleshoot,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final gangguanId = extra['gangguanId'] as int;
          final serviceId = extra['serviceId'] as int;
          return TroubleshootPage(
            gangguanId: gangguanId,
            serviceId: serviceId,
          );
        },
      ),
      GoRoute(
        path: '/notification',
        name: RouteName.notification,
        builder: (context, state) => const NotificationPage(),
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
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final ticketId = extra['ticketId'] as int;
          final type = extra['type'] as String;
          return AdminTicketDetailPage(
            ticketId: ticketId,
            type: type,
          );
        },
      ),
      GoRoute(
        path: '/ba',
        name: RouteName.ba,
        builder: (context, state) => const BaPage(),
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
      GoRoute(
        path: '/ba-form',
        name: RouteName.baForm,
        builder: (context, state) => const BaFormPage(),
      ),
    ],
  );
}
