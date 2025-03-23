import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../utils/assets.gen.dart';
import '../widgets/setting_tile_widget.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          children: [
            SvgPicture.asset(
              Assets.icons.setting.path,
              height: 80,
              width: 80,
              fit: BoxFit.contain,
            ),
            const Gap(20),
            Center(
              child: Text(
                'Setting',
                style: GoogleFonts.montserrat(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Gap(24),
            SettingTile(
              title: 'Profile',
              icon: Assets.icons.editSolid.path,
              onTap: () {},
            ),
            SettingTile(
              title: 'Ubah Password',
              icon: Assets.icons.changePassword.path,
              onTap: () {},
            ),
            SettingTile(
              title: 'Helpdesk',
              icon: Assets.icons.helpdesk.path,
              onTap: () {},
            ),
            SettingTile(
              isLogout: true,
              title: 'Keluar',
              icon: Assets.icons.logout.path,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
