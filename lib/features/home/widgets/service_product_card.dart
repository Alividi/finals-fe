import 'package:finals_fe/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ServiceProductCard extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;
  final bool hasDropdown;
  final IconData? dropdownIcon;

  const ServiceProductCard({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.hasDropdown = false,
    this.dropdownIcon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 130,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  begin: Alignment(0.00, -1.00),
                  end: Alignment(0, 1),
                  colors: AppColor.newGradientPurple,
                )
              : null,
          color: isSelected ? null : const Color(0xFF242134),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label,
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (hasDropdown) const SizedBox(width: 5),
            if (hasDropdown)
              Icon(
                dropdownIcon,
                color: Colors.white,
                size: 32.0,
              ),
          ],
        ),
      ),
    );
  }
}
