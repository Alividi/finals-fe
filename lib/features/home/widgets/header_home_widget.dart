import 'package:badges/badges.dart' as badges;
import 'package:finals_fe/utils/app_color.dart';
import 'package:finals_fe/utils/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderHome extends StatelessWidget {
  final VoidCallback onTap;
  final String? name;
  final int? badgeCount;

  const HeaderHome({
    super.key,
    required this.onTap,
    this.name = 'User',
    this.badgeCount,
  });

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
          child: badges.Badge(
            showBadge: badgeCount != null && badgeCount! > 0,
            badgeContent: Text(
              '$badgeCount',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
            position: badges.BadgePosition.topEnd(top: -4, end: -4),
            badgeStyle: const badges.BadgeStyle(
              badgeColor: AppColor.lightRed,
              padding: EdgeInsets.all(4),
            ),
            child: Container(
              width: 44,
              height: 44,
              decoration: const ShapeDecoration(
                color: AppColor.blueBackground,
                shape: OvalBorder(),
              ),
              child: Center(
                child: SvgPicture.asset(
                  Assets.icons.bell.path,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
