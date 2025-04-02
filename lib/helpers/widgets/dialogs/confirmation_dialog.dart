import 'package:finals_fe/helpers/widgets/buttons/buttons.dart';
import 'package:finals_fe/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String? description;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final String? iconPath;
  final Color? confirmColor;
  final Color? cancelColor;
  final Color? textColor;
  final Color? borderColor;

  const ConfirmationDialog({
    super.key,
    required this.title,
    this.description,
    required this.confirmText,
    required this.cancelText,
    required this.onConfirm,
    this.onCancel,
    this.iconPath,
    this.confirmColor,
    this.cancelColor,
    this.textColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColor.blueBackground,
      contentPadding: const EdgeInsets.symmetric(horizontal: 27, vertical: 22),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (iconPath != null)
            SvgPicture.asset(
              iconPath!,
              height: 50,
              width: 50,
              fit: BoxFit.contain,
              colorFilter: const ColorFilter.mode(
                Color(0xFFFD6464),
                BlendMode.srcIn,
              ),
            ),
          if (iconPath != null) const Gap(24),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (description != null) const Gap(12),
          if (description != null)
            Text(
              description!,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          const Gap(24),
          Button.filled(
            onPressed: onConfirm,
            label: confirmText,
            textColor: textColor ?? AppColor.white,
            color: confirmColor ?? AppColor.lightRed,
          ),
          const Gap(8),
          Button.outlined(
            onPressed: onCancel ?? () => Navigator.pop(context),
            label: cancelText,
            borderColor: borderColor ?? AppColor.darkGrey,
          ),
        ],
      ),
    );
  }
}
