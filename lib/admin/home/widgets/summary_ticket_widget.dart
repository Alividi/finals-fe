import 'package:finals_fe/admin/home/widgets/summary_tile_widget.dart';
import 'package:finals_fe/extensions/build_context.ext.dart';
import 'package:finals_fe/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class SummaryTicketWidget extends StatelessWidget {
  const SummaryTicketWidget({
    super.key,
    required this.selectedMonth,
  });

  final ValueNotifier<String> selectedMonth;

  @override
  Widget build(BuildContext context) {
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
                'Rinkasan Tiket',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              Gap(context.deviceWidth * 0.1),
              Expanded(
                child: Container(
                  width: 200,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColor.darkGrey,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropdownButton<String>(
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
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Gap(16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SummaryTileWidget(),
              SummaryTileWidget(
                title: 'Masuk',
                color: AppColor.darkBlue,
              ),
              SummaryTileWidget(
                title: 'Selesai',
                color: AppColor.green,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
