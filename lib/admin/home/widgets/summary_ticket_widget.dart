import 'package:finals_fe/admin/home/widgets/summary_tile_widget.dart';
import 'package:finals_fe/admin/ticket/domain/entities/ticket_summary_model.dart';
import 'package:finals_fe/extensions/build_context.ext.dart';
import 'package:finals_fe/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SummaryTicketWidget extends StatelessWidget {
  final ValueNotifier<String> selectedMonth;
  final AsyncValue<TicketSummaryModel> summaryAsync;
  final String? type;
  const SummaryTicketWidget({
    super.key,
    required this.selectedMonth,
    required this.summaryAsync,
    this.type = 'admin',
  });

  @override
  Widget build(BuildContext context) {
    TicketSummaryModel? summary;
    if (summaryAsync is AsyncData<TicketSummaryModel>) {
      summary = summaryAsync.asData!.value;
    }

    Widget buildTile(String title, Color color, int? value) {
      return SummaryTileWidget(
        title: title,
        color: color,
        valueWidget: summaryAsync.isLoading
            ? const SizedBox(
                height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
            : Text(
                '${value ?? 0}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
      );
    }

    return Container(
      height: context.deviceHeight * 0.21,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColor.blueBackground,
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Ringkasan Tiket',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              Gap(context.deviceWidth * 0.1),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColor.darkGrey,
                  ),
                  child: DropdownButton<String>(
                    value: selectedMonth.value,
                    isDense: true,
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white),
                    iconSize: 24,
                    elevation: 16,
                    dropdownColor: const Color(0xFF242134),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: GoogleFonts.montserrat().fontFamily,
                      fontWeight: FontWeight.w500,
                    ),
                    underline: Container(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        selectedMonth.value = newValue;
                      }
                    },
                    items: <String>[
                      'Januari',
                      'Februari',
                      'Maret',
                      'April',
                      'Mei',
                      'Juni',
                      'Juli',
                      'Agustus',
                      'September',
                      'Oktober',
                      'November',
                      'Desember',
                      'Semua'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
          const Gap(16),
          if (type == 'admin') ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildTile('Total', AppColor.darkGrey, summary?.totalCount),
                buildTile('Masuk', AppColor.darkBlue, summary?.openCount),
                buildTile('Selesai', AppColor.green, summary?.closedCount),
              ],
            ),
          ],
          if (type == 'teknisi') ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildTile('Total', AppColor.darkBlue, summary?.totalCount),
                buildTile('Selesai', AppColor.green, summary?.closedCount),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
