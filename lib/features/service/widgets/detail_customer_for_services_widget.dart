import 'package:finals_fe/features/service/widgets/detail_service_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailCustomerForServicesWidget extends StatelessWidget {
  const DetailCustomerForServicesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Last Update',
            style: TextStyle(
              color: const Color(0xFF6E6B7F),
              fontSize: 12,
              fontFamily: GoogleFonts.montserrat().fontFamily,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            '23/03/2025 14:30:45',
            style: TextStyle(
              color: const Color(0xFFFCFCFC),
              fontSize: 16,
              fontFamily: GoogleFonts.montserrat().fontFamily,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Gap(24),
          const DetailServiceCardWidget(
            title: 'Customer',
            value: 'Nama Customer',
          ),
          const Gap(10),
          const DetailServiceCardWidget(
            title: 'Up Time',
            value: '0D 0H 0M 0S',
          ),
          const Gap(10),
          const DetailServiceCardWidget(
            title: 'SSID',
            value: 'SSID',
          ),
          const Gap(10),
          const DetailServiceCardWidget(
            title: 'SERVICE LINE NUMBER',
            value: 'SN-123456',
          ),
          const Gap(10),
          const DetailServiceCardWidget(
            title: 'KIT SERIAL NUMBER',
            value: 'KIT-123456',
          ),
          const Gap(10),
          const DetailServiceCardWidget(
            title: 'IP KIT',
            value: '1',
          ),
          const Gap(10),
          const DetailServiceCardWidget(
            title: 'SERVICE ADDRESS',
            value: 'Jl. Jalan',
          ),
          const Gap(10),
          const DetailServiceCardWidget(
            title: 'Tanggal Aktivasi',
            value: '01 Januari 2000',
          ),
          const Gap(10),
          const DetailServiceCardWidget(
            title: 'Perangkat',
            value: 'Perangkat',
          ),
          const Gap(10),
        ],
      ),
    );
  }
}
