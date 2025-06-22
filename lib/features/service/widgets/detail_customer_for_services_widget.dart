import 'package:finals_fe/features/service/domain/entities/service_detail_model.dart';
import 'package:finals_fe/features/service/widgets/detail_service_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // for formatting DateTime

class DetailCustomerForServicesWidget extends StatelessWidget {
  final ServiceDetailModel data;

  const DetailCustomerForServicesWidget({
    super.key,
    required this.data,
  });

  String formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return '-';
    return DateFormat('dd/MM/yyyy HH:mm:ss').format(dateTime);
  }

  String formatActivationDate(DateTime? dateTime) {
    if (dateTime == null) return '-';
    return DateFormat('dd MMMM yyyy', 'id_ID').format(dateTime);
  }

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
            formatDateTime(DateTime.now()),
            style: TextStyle(
              color: const Color(0xFFFCFCFC),
              fontSize: 16,
              fontFamily: GoogleFonts.montserrat().fontFamily,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Gap(24),
          DetailServiceCardWidget(
            title: 'Customer',
            value: data.customerName ?? '-',
          ),
          const Gap(10),
          // const DetailServiceCardWidget(
          //   title: 'Up Time',
          //   value: '0D 0H 0M 0S',
          // ),
          // const Gap(10),
          DetailServiceCardWidget(
            title: 'SSID',
            value: data.ssid ?? '-',
          ),
          const Gap(10),
          DetailServiceCardWidget(
            title: 'SERVICE LINE NUMBER',
            value: data.serviceLineNumber ?? '-',
          ),
          const Gap(10),
          DetailServiceCardWidget(
            title: 'KIT SERIAL NUMBER',
            value: data.kitSn ?? '-',
          ),
          const Gap(10),
          DetailServiceCardWidget(
            title: 'IP KIT',
            value: data.ipKit ?? '-',
          ),
          const Gap(10),
          DetailServiceCardWidget(
            title: 'SERVICE ADDRESS',
            value: data.addressLine ?? '-',
          ),
          const Gap(10),
          DetailServiceCardWidget(
            title: 'Tanggal Aktivasi',
            value: formatActivationDate(data.activationDate),
          ),
          const Gap(10),
          DetailServiceCardWidget(
            title: 'Perangkat',
            value: data.device ?? '-',
          ),
          const Gap(10),
        ],
      ),
    );
  }
}
