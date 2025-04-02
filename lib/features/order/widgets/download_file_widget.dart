import 'package:finals_fe/utils/app_color.dart';
import 'package:finals_fe/utils/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class DownloadFileWidget extends StatelessWidget {
  final String text;
  final double width;

  const DownloadFileWidget({
    super.key,
    required this.text,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      width: width,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColor.darkGrey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      height: 48,
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Transform.scale(
              scale: 1.5,
              child: SvgPicture.asset(
                Assets.icons.download.path,
                fit: BoxFit.cover,
                color: AppColor.darkGrey,
              ),
            ),
            const Gap(10),
            Text(
              text,
              style: GoogleFonts.montserrat(
                color: AppColor.darkGrey,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
