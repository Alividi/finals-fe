import 'package:finals_fe/utils/app_color.dart';
import 'package:finals_fe/utils/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderHome extends StatelessWidget {
  final VoidCallback onTap;
  final String? name;
  const HeaderHome({super.key, required this.onTap, this.name = 'User'});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hallo',
              style: GoogleFonts.montserrat(
                color: const Color(0xFFADADAD),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '$name!',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const Spacer(),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 44,
            height: 44,
            decoration: const ShapeDecoration(
              color: AppColor.blueBackground,
              shape: OvalBorder(),
            ),
            child: Stack(
              children: [
                Center(
                  child: SvgPicture.asset(
                    Assets.icons.bell.path,
                    fit: BoxFit.cover,
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    height: 10,
                    width: 10,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.lightRed,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
