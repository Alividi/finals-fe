import 'package:finals_fe/core/provider/user_manager_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:finals_fe/extensions/build_context.ext.dart';
import 'package:finals_fe/routers/router_name.dart';
import 'package:finals_fe/utils/assets.gen.dart';

class Splashscreen extends StatefulHookConsumerWidget {
  const Splashscreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashscreenState();
}

class _SplashscreenState extends ConsumerState<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async {
      final userManager = await ref.read(userManagerProvider.future);
      final hasUser = await userManager.hasUser();

      if (hasUser) {
        final user = await userManager.getUser();
        final role = user?.role?.toLowerCase();

        if (role == 'customer') {
          if (!mounted) return;
          context.go(RouteName.main);
          return;
        } else if (role == 'admin') {
          if (!mounted) return;
          context.go(RouteName.adminMain);
          return;
        } else if (role == 'teknisi') {
          if (!mounted) return;
          context.go(RouteName.technicianMain);
          return;
        }
      }

      if (!mounted) return;
      context.go(RouteName.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1323),
      body: Column(
        children: [
          const Spacer(),
          Stack(
            children: [
              Image.asset(
                Assets.images.mountainElement.path,
                fit: BoxFit.cover,
                height: context.deviceHeight * 0.6,
                width: context.deviceWidth,
              ),
              Center(
                child: Hero(
                  tag: 'logo',
                  child: Image.asset(
                    Assets.images.logoApp.path,
                    height: 94,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
