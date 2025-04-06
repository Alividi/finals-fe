import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finals_fe/utils/app_color.dart';
import 'package:finals_fe/utils/assets.gen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? trailling;
  final VoidCallback? onBack;

  const CustomAppBar({super.key, this.title, this.onBack, this.trailling});

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
                width: 55,
                height: 55,
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
      actions: trailling != null
          ? [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: trailling,
              ),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}
