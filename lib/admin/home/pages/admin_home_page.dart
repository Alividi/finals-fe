import 'package:finals_fe/admin/home/widgets/home_ticket_card.dart';
import 'package:finals_fe/admin/home/widgets/home_title_dropdown_widget.dart';
import 'package:finals_fe/admin/home/widgets/summary_ticket_widget.dart';
import 'package:finals_fe/core/domain/entities/user_model.dart';
import 'package:finals_fe/core/provider/user_manager_provider.dart';
import 'package:finals_fe/features/home/widgets/header_home_widget.dart';
import 'package:finals_fe/features/setting/controllers/user_controllers.dart';
import 'package:finals_fe/routers/router_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdminHomePage extends HookConsumerWidget {
  const AdminHomePage({super.key});

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
    final userStatusAsync = ref.watch(userStatusControllerProvider);
    final selectedMonth = useState<String>('April');
    final selectedStatus = useState<String>('Semua');
    final List<String> status = [
      'Semua',
      'Masuk',
      'Proses',
      'Selesai',
    ];
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
              SummaryTicketWidget(
                selectedMonth: selectedMonth,
              ),
              const Gap(20),
              HomeTitleDropdownWidget(
                title: 'Tiket Hari ini',
                selected: selectedStatus,
                items: status,
              ),
              const Gap(16),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return HomeTicketCard(
                      onTap: () {
                        context.pushNamed(RouteName.adminTicketDetail);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
