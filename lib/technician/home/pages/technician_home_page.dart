import 'package:finals_fe/admin/home/widgets/summary_ticket_widget.dart';
import 'package:finals_fe/admin/ticket/controllers/ticket_controllers.dart';
import 'package:finals_fe/admin/ticket/domain/entities/ticket_summary_model.dart';
import 'package:finals_fe/admin/ticket/domain/entities/tickets_params.dart';
import 'package:finals_fe/admin/ticket/widgets/ticket_card.dart';
import 'package:finals_fe/core/domain/entities/user_model.dart';
import 'package:finals_fe/core/provider/user_manager_provider.dart';
import 'package:finals_fe/features/home/widgets/header_home_widget.dart';
import 'package:finals_fe/features/setting/controllers/user_controllers.dart';
import 'package:finals_fe/helpers/format/text_format_helper.dart';
import 'package:finals_fe/routers/router_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TechnicianHomePage extends HookConsumerWidget {
  const TechnicianHomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = useState<UserModel?>(null);
    final isLoading = useState(true);
    final currentMonth = DateTime.now().month;
    final selectedMonth = useState<String>(monthsList[currentMonth - 1]);
    final summaryAsync = useState<AsyncValue<TicketSummaryModel>>(const AsyncLoading());

    useEffect(() {
      Future.microtask(() async {
        final userManager = await ref.read(userManagerProvider.future);
        final user = await userManager.getUser();
        userState.value = user;
        isLoading.value = false;
      });
      return null;
    }, []);

    useEffect(() {
      Future.microtask(() async {
        summaryAsync.value = const AsyncLoading();
        try {
          final result = await ref.read(
            getTicketSummaryProvider(
              TicketSummaryParams(
                month: selectedMonth.value != 'Semua' ? monthsMap[selectedMonth.value] : null,
              ),
            ).future,
          );
          summaryAsync.value = AsyncData(result);
        } catch (e, st) {
          summaryAsync.value = AsyncError(e, st);
        }
      });
      return null;
    }, [selectedMonth.value]);

    final userStatusAsync = ref.watch(userStatusControllerProvider);

    final ticketsParams = useMemoized(() {
      return TicketsParams(
        status: null,
        keyword: null,
      );
    });

    final ticketListAsync = ref.watch(getTicketsProvider(ticketsParams));

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                summaryAsync: summaryAsync.value,
                type: 'teknisi',
              ),
              const Gap(20),
              const Text(
                'Tiketmu',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(16),
              Expanded(
                child: ticketListAsync.when(
                  data: (tickets) {
                    if (tickets.isEmpty) {
                      return const Center(child: Text('Tidak ada tiket'));
                    }
                    return ListView.builder(
                      itemCount: tickets.length,
                      itemBuilder: (context, index) {
                        final ticket = tickets[index];
                        return TicketCard(
                          ticket: ticket,
                          onTap: () {
                            context.pushNamed(RouteName.adminTicketDetail, extra: {
                              'ticketId': ticket.id,
                              'type': 'teknisi',
                            });
                          },
                        );
                      },
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, st) => Center(child: Text('Terjadi kesalahan: $e')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
