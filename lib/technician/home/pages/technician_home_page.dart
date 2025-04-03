import 'package:finals_fe/admin/ticket/widgets/ticket_card.dart';
import 'package:finals_fe/features/home/widgets/header_home_widget.dart';
import 'package:finals_fe/routers/router_name.dart';
import 'package:finals_fe/technician/home/widgets/summary_ticket_technician_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TechnicianHomePage extends HookConsumerWidget {
  const TechnicianHomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedMonth = useState<String>('April');

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              HeaderHome(
                name: 'Teknisi',
                onTap: () {},
              ),
              const Gap(20),
              SummaryTicketTechnicianWidget(
                selectedMonth: selectedMonth,
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
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return TicketCard(
                      onTap: () {
                        context.pushNamed(RouteName.technicianTicketDetail);
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
