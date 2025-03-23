import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/assets.gen.dart';

class SeeAllMenu extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap;
  const SeeAllMenu({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          icon,
          width: 21,
          height: 21,
        ),
        const Gap(10),
        Text(
          title,
          style: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: onTap,
          child: SizedBox(
            height: 22,
            child: Row(
              children: [
                Text(
                  'Lihat Semua',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(14),
                SvgPicture.asset(
                  Assets.icons.arrow.path,
                  width: 12,
                  height: 12,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
