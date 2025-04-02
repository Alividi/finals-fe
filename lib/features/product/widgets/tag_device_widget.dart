import 'package:finals_fe/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TagDeviceWidget extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const TagDeviceWidget({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.darkGrey : AppColor.darkGrey,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? AppColor.darkGrey : AppColor.darkGrey,
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.montserrat(
            color: isSelected ? AppColor.white : AppColor.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}
