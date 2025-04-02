import 'package:finals_fe/admin/home/pages/admin_home_page.dart';
import 'package:finals_fe/admin/ticket/pages/admin_ticket_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:finals_fe/features/main/controllers/selected_index_provider.dart';
import 'package:finals_fe/features/main/widgets/nav_item.dart';
import 'package:finals_fe/features/setting/pages/setting_page.dart';

import 'package:finals_fe/utils/assets.gen.dart';

class AdminMainPage extends HookConsumerWidget {
  final int id;
  const AdminMainPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int selectedIndex = ref.watch(selectedIndexNavBar);
    final List<Widget> selectedPage = <Widget>[
      const AdminHomePage(),
      const AdminTicketPage(),
      const SettingPage(),
    ];

    void onItemTapped(int index) {
      ref.read(selectedIndexNavBar.notifier).update((state) => index);
    }

    return Scaffold(
      body: selectedPage[selectedIndex],
      bottomNavigationBar: IntrinsicHeight(
        child: Container(
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavItem(
                iconPath: Assets.navbar.home.path,
                label: 'Beranda',
                isActive: selectedIndex == 0,
                onTap: () {
                  onItemTapped(0);
                },
              ),
              NavItem(
                iconPath: Assets.navbar.ticket.path,
                label: 'Tiket',
                middle: true,
                isActive: selectedIndex == 1,
                onTap: () {
                  onItemTapped(1);
                },
              ),
              NavItem(
                iconPath: Assets.navbar.setting.path,
                label: 'Setting',
                isActive: selectedIndex == 2,
                onTap: () {
                  onItemTapped(2);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
