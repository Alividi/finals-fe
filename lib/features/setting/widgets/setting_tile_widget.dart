import 'package:finals_fe/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingTile extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap;
  final bool isLogout;
  const SettingTile({
    super.key,
    required this.title,
    required this.onTap,
    required this.icon,
    this.isLogout = false,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            child: SizedBox(
              height: 50,
              child: Row(
                children: [
                  SvgPicture.asset(
                    icon,
                    height: 20,
                    width: 20,
                    colorFilter: ColorFilter.mode(
                      isLogout ? AppColor.lightRed : Colors.white,
                      BlendMode.srcIn,
                    ),
                    fit: BoxFit.contain,
                  ),
                  const Gap(20),
                  Expanded(
                    child: Text(
                      title,
                      style: GoogleFonts.montserrat(
                        color: isLogout ? AppColor.lightRed : Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
