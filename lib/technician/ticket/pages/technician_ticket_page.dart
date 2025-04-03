import 'package:finals_fe/admin/ticket/widgets/ticket_card.dart';
import 'package:finals_fe/routers/router_name.dart';
import 'package:finals_fe/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TechnicianTicketPage extends HookConsumerWidget {
  const TechnicianTicketPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedStatus = useState<String>('Semua');
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 40,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Tiket",
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(20),
            const TextField(
              decoration: InputDecoration(
                hintText: "Cari Tiket",
                hintStyle: TextStyle(color: AppColor.lightGrey),
                prefixIcon: Icon(Icons.search, color: AppColor.lightGrey),
                filled: true,
                fillColor: AppColor.blueBackground,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const Gap(20),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFF242134)),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Status tiket',
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
                        selectedStatus.value = newValue;
                      }
                    },
                    items: <String>[
                      'Semua',
                      'Masuk',
                      'Proses',
                      'Selesai',
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
            const Gap(12),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
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
    );
  }
}
