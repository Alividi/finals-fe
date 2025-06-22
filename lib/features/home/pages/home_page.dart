import 'package:finals_fe/core/domain/entities/user_model.dart';
import 'package:finals_fe/core/provider/user_manager_provider.dart';
import 'package:finals_fe/features/home/widgets/header_home_widget.dart';
import 'package:finals_fe/features/home/widgets/home_products.dart';
import 'package:finals_fe/features/home/widgets/home_widget.dart';
import 'package:finals_fe/features/home/widgets/see_all_menu_widget.dart';
import 'package:finals_fe/features/main/controllers/selected_index_provider.dart';
import 'package:finals_fe/features/setting/controllers/user_controllers.dart';
import 'package:finals_fe/routers/router_name.dart';
import 'package:finals_fe/utils/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = useState<UserModel?>(null);
    final isLoading = useState(true);

    useEffect(() {
      Future.microtask(() async {
        final userManager = await ref.read(userManagerProvider.future);
        final user = await userManager.getUser();
        userState.value = user;
        isLoading.value = false;
      });
      return null;
    }, []);

    final tabController = useTabController(initialLength: 3);
    final userStatusAsync = ref.watch(userStatusControllerProvider);

    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            isLoading.value || userStatusAsync.isLoading
                ? HeaderHome(onTap: () {}, name: '')
                : userStatusAsync.hasError
                    ? HeaderHome(onTap: () {}, name: userState.value?.username ?? '')
                    : HeaderHome(
                        onTap: () {
                          context.pushNamed(RouteName.notification);
                        },
                        name: userState.value?.username ?? '',
                        badgeCount: userStatusAsync.value?.notificationCount ?? 0,
                      ),
            const Gap(20),
            SeeAllMenu(
              title: 'Promosi',
              icon: Assets.icons.discount.path,
              onTap: () {},
            ),
            const Gap(20),
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
            ),
            const Gap(24),
            SeeAllMenu(
              title: 'Layanan Saya',
              icon: Assets.icons.satelite.path,
              onTap: () {
                ref.read(selectedIndexNavBar.notifier).update((state) => 2);
              },
            ),
            const Gap(32),
            HomeWidget(tabController: tabController),
            const Gap(24),
            SeeAllMenu(
              title: 'Produk',
              icon: Assets.icons.airship.path,
              onTap: () {
                ref.read(selectedIndexNavBar.notifier).update((state) => 1);
              },
            ),
            const Gap(16),
            SizedBox(
              height: 310,
              child: CustomScrollView(
                scrollDirection: Axis.horizontal,
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: HomeProducts(onTap: () {})),
                      childCount: 3,
                    ),
                  )
                ],
              ),
            ),
            const Gap(24),
          ],
        ),
      ),
    );
  }
}
