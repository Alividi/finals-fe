import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/app_color.dart';
import '../../../utils/assets.gen.dart';

class NotificationCard extends StatelessWidget {
  final bool isRead;
  final String title;
  final String description;
  final String time;

  const NotificationCard({
    super.key,
    required this.isRead,
    required this.title,
    required this.description,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        color: isRead ? Colors.transparent : const Color(0xFF181624),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 28,
              height: 28,
              child: SvgPicture.asset(
                fit: BoxFit.contain,
                Assets.icons.satelite.path,
                colorFilter: isRead
                    ? const ColorFilter.mode(
                        AppColor.lightBlue,
                        BlendMode.srcIn,
                      )
                    : null,
              ),
            ),
            const Gap(20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: isRead ? AppColor.lightBlue : null,
                    ),
                  ),
                  const Gap(1),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Text(
                      description,
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const Gap(5),
                  Text(
                    time,
                    style: GoogleFonts.montserrat(
                      color: AppColor.disable,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Gap(5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
