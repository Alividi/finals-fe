import 'package:finals_fe/extensions/build_context.ext.dart';
import 'package:finals_fe/helpers/widgets/appbar/custom_app_bar.dart';
import 'package:finals_fe/helpers/widgets/buttons/buttons.dart';
import 'package:finals_fe/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdminTicketDetailPage extends HookConsumerWidget {
  const AdminTicketDetailPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedStatus = useState<String>('Silahkan Pilih');
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Detail Tiket',
        onBack: () {
          Navigator.pop(context);
        },
      ),
      body: Padding(
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
                      const Text(
                        'TK-0001',
                        style: TextStyle(
                          fontSize: 24,
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
                          color: AppColor.darkBlue,
                        ),
                        child: const Text(
                          'Masuk',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const Gap(12),
                const Divider(
                  color: AppColor.lightGrey,
                  thickness: 1,
                ),
                const Gap(12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Nama Pelangan',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gap(8),
                    Text(
                      '10 April 2024',
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
                const Column(
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
                      value: '2272022020001',
                    ),
                    Gap(8),
                    TicketServiceDetail(
                      title: 'SERVICE LINE NUMBER',
                      value: 'AST-178642-65135-54',
                    ),
                    Gap(8),
                    TicketServiceDetail(
                      title: 'KIT SERIAL NUMBER',
                      value: 'KITP00032016',
                    ),
                    Gap(8),
                    TicketServiceDetail(
                      title: 'IP KIT',
                      value: '10.201.6.122',
                    ),
                    Gap(8),
                    TicketServiceDetail(
                      title: 'SERVICE ADDRESS',
                      value: 'Site Konawe - Padelere Utama',
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
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: AppColor.darkBlue,
                      ),
                      child: const Text(
                        'Gangguan pada layanan internet, tidak bisa mengakses internet',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColor.white,
                        ),
                      ),
                    )
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
                      'Tugaskan teknisi',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(20),
                    Container(
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
                          DropdownButton<String>(
                            value: selectedStatus.value,
                            isDense: true,
                            isExpanded: true,
                            icon:
                                const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white),
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
                                selectedStatus.value = newValue;
                              }
                            },
                            items: <String>[
                              'Silahkan Pilih',
                              'Teknisi 1',
                              'Teknisi 2',
                              'Teknisi 3',
                              'Teknisi 4',
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
                    const Gap(20),
                    Button.filled(onPressed: () {}, label: 'Tugaskan')
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TicketServiceDetail extends StatelessWidget {
  final String? title;
  final String? value;
  const TicketServiceDetail({
    this.title,
    this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: context.deviceWidth * 0.36,
          child: Text(
            title ?? 'Title',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColor.lightGrey,
            ),
          ),
        ),
        const Text(
          ':',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColor.lightGrey,
          ),
        ),
        const Gap(12),
        Flexible(
          child: Text(
            value ?? 'Value',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColor.lightGrey,
            ),
          ),
        ),
      ],
    );
  }
}
