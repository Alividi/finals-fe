import 'dart:developer';

import 'package:finals_fe/admin/ticket/controllers/ticket_controllers.dart';
import 'package:finals_fe/admin/ticket/domain/entities/tickets_params.dart';
import 'package:finals_fe/admin/ticket/widgets/ticket_service_detail.dart';
import 'package:finals_fe/features/setting/controllers/user_controllers.dart';
import 'package:finals_fe/features/setting/domain/entities/technicians_model.dart';
import 'package:finals_fe/helpers/format/text_format_helper.dart';
import 'package:finals_fe/helpers/widgets/appbar/custom_app_bar.dart';
import 'package:finals_fe/helpers/widgets/buttons/buttons.dart';
import 'package:finals_fe/routers/router_name.dart';
import 'package:finals_fe/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdminTicketDetailPage extends HookConsumerWidget {
  final int ticketId;
  final String type;
  const AdminTicketDetailPage({super.key, required this.ticketId, required this.type});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTechnician = useState<TechniciansModel?>(null);
    final ticketDetailAsync = ref.watch(getTicketDetailProvider(ticketId));
    final techniciansAsync = ref.watch(techniciansControllerProvider);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Detail Tiket',
        onBack: () {
          Navigator.pop(context);
        },
      ),
      body: ticketDetailAsync.when(
        data: (ticket) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColor.blueBackground,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Text(
                            ticket.nomorTiket ?? '',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(8),
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
                          ),
                        ],
                      ),
                    ),
                    const Gap(12),
                    const Divider(
                      color: AppColor.lightGrey,
                      thickness: 1,
                    ),
                    const Gap(12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          ticket.namaPerusahaan ?? '',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Gap(8),
                        Text(
                          formatToIndonesianDate(ticket.createdAt.toString()),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColor.lightGrey,
                          ),
                        ),
                      ],
                    ),
                    const Gap(12),
                    const Divider(
                      color: AppColor.lightGrey,
                      thickness: 1,
                    ),
                    const Gap(12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Informasi layanan :',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Gap(8),
                        TicketServiceDetail(
                          title: 'SSID',
                          value: ticket.ssid ?? 'Tidak ada SSID',
                        ),
                        Gap(8),
                        TicketServiceDetail(
                          title: 'SERVICE LINE NUMBER',
                          value: ticket.serviceLineNumber ?? 'Tidak ada nomor layanan',
                        ),
                        Gap(8),
                        TicketServiceDetail(
                          title: 'KIT SERIAL NUMBER',
                          value: ticket.kitSn ?? 'Tidak ada nomor seri KIT',
                        ),
                        Gap(8),
                        TicketServiceDetail(
                          title: 'IP KIT',
                          value: ticket.ipKit ?? 'Tidak ada IP KIT',
                        ),
                        Gap(8),
                        TicketServiceDetail(
                          title: 'SERVICE ADDRESS',
                          value: ticket.addressLine ?? 'Tidak ada alamat layanan',
                        ),
                      ],
                    ),
                    const Gap(12),
                    const Divider(
                      color: AppColor.lightGrey,
                      thickness: 1,
                    ),
                    const Gap(12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'Gangguan :',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Gap(8),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: AppColor.darkBlue,
                          ),
                          child: Text(
                            ticket.namaGangguan ?? '',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColor.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    if (type == 'admin' && ticket.status == 'open') ...[
                      const Gap(12),
                      const Divider(
                        color: AppColor.lightGrey,
                        thickness: 1,
                      ),
                      const Gap(12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Tugaskan teknisi',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(20),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(width: 1, color: AppColor.darkPurple),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Teknisi',
                                  style: TextStyle(
                                    color: const Color(0xFF6E6B7F),
                                    fontSize: 12,
                                    fontFamily: GoogleFonts.montserrat().fontFamily,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Gap(5),
                                techniciansAsync.when(
                                  data: (technicians) {
                                    return DropdownButton<TechniciansModel>(
                                      value: selectedTechnician.value,
                                      isDense: true,
                                      isExpanded: true,
                                      icon: const Icon(Icons.keyboard_arrow_down_rounded,
                                          color: Colors.white),
                                      iconSize: 24,
                                      elevation: 16,
                                      dropdownColor: const Color(0xFF242134),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: GoogleFonts.montserrat().fontFamily,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      hint: const Text('Silahkan Pilih',
                                          style: TextStyle(color: Colors.white)),
                                      underline: Container(),
                                      onChanged: (TechniciansModel? newValue) {
                                        selectedTechnician.value = newValue;
                                      },
                                      items: technicians.map<DropdownMenuItem<TechniciansModel>>(
                                          (TechniciansModel tech) {
                                        return DropdownMenuItem<TechniciansModel>(
                                          value: tech,
                                          child: Text(tech.nama ?? 'Tanpa Nama'),
                                        );
                                      }).toList(),
                                    );
                                  },
                                  loading: () => Center(child: const CircularProgressIndicator()),
                                  error: (error, _) => Text('Error loading technicians: $error'),
                                ),
                              ],
                            ),
                          ),
                          const Gap(20),
                          Button.filled(
                              onPressed: () async {
                                if (selectedTechnician.value == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Silahkan pilih teknisi terlebih dahulu'),
                                    ),
                                  );
                                  return;
                                }
                                final selectedId = selectedTechnician.value?.id;
                                final params = AssignTicketParams(
                                  ticketId: ticket.id ?? 0,
                                  teknisiId: selectedId ?? 0,
                                );
                                try {
                                  final result =
                                      await ref.read(assignTicketProvider(params).future);
                                  log('Assign Ticket Result: $result');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Tiket berhasil ditugaskan ke teknisi')),
                                  );
                                  context.pop();
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Gagal menugaskan tiket: $e')),
                                  );
                                }
                              },
                              label: 'Tugaskan')
                        ],
                      ),
                    ],
                    if (type == 'teknisi' && ticket.status == 'in_progress') ...[
                      const Gap(20),
                      Button.filled(
                          onPressed: () {
                            context.pushNamed(RouteName.baForm, extra: {
                              'ticketId': ticket.id,
                            });
                          },
                          label: 'Isi Berita Acara'),
                    ],
                    if (ticket.status == 'closed') ...[
                      const Gap(20),
                      Button.filled(
                          onPressed: () {
                            context.pushNamed(RouteName.ba, extra: {
                              'ticketId': ticket.id,
                            });
                          },
                          label: 'Lihat Berita Acara'),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text('Error loading ticket details: $error'),
        ),
      ),
    );
  }
}
