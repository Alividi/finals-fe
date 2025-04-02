import 'package:finals_fe/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeTitleDropdownWidget extends StatelessWidget {
  const HomeTitleDropdownWidget({
    super.key,
    required this.selected,
    required this.items,
    this.title = 'Title',
  });

  final ValueNotifier<String> selected;
  final List<String> items;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        Expanded(
          child: Container(
            width: 200,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColor.blueBackground,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButton<String>(
                  value: selected.value,
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
                      selected.value = newValue;
                    }
                  },
                  items: items.map<DropdownMenuItem<String>>((String value) {
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
    );
  }
}
