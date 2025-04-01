import 'package:finals_fe/utils/app_color.dart';
import 'package:finals_fe/utils/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBarDetailProduct extends StatelessWidget implements PreferredSizeWidget {
  final String? title;

  final VoidCallback? onBack;

  const CustomAppBarDetailProduct({super.key, this.title, this.onBack});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.darkBackground,
      leadingWidth: 75,
      titleSpacing: 20,
      title: Text(
        title!,
        style: TextStyle(
          color: const Color(0xFFADADAD),
          fontSize: 14,
          fontFamily: GoogleFonts.montserrat().fontFamily,
          fontWeight: FontWeight.w400,
        ),
      ),
      leading: onBack != null
          ? Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.blueBackground,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: IconButton(
                  icon: SvgPicture.asset(
                    Assets.icons.back.path,
                    width: 20,
                  ),
                  onPressed: () {
                    onBack!();
                  },
                ),
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}
