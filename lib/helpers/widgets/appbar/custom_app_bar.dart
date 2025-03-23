import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finals_fe/utils/app_color.dart';
import 'package:finals_fe/utils/assets.gen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;

  final VoidCallback? onBack;

  const CustomAppBar({super.key, this.title, this.onBack});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.darkBackground,
      leadingWidth: 75,
      titleSpacing: 20,
      title: Text(
        title!,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
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
