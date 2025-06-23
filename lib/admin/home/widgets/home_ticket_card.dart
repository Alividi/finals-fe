import 'package:finals_fe/admin/ticket/domain/entities/tickets_model.dart';
import 'package:finals_fe/helpers/format/text_format_helper.dart';
import 'package:finals_fe/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeTicketCard extends StatelessWidget {
  final TicketsModel ticket;
  final VoidCallback? onTap;
  const HomeTicketCard({
    this.onTap,
    required this.ticket,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColor.blueBackground,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  ticket.nomorTiket ?? '',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColor.getTicketStatusColor(ticket.status),
                  ),
                  child: Text(
                    getTicketStatusColor(ticket.status),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColor.getTicketStatusTextColor(ticket.status),
                    ),
                  ),
                )
              ],
            ),
            if (ticket.namaTeknisi != '') ...[
              const Gap(8),
              Text(
                'Teknisi: ${ticket.namaTeknisi}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
