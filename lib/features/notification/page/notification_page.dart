import 'package:finals_fe/features/notification/widgets/notification_card.dart';
import 'package:finals_fe/helpers/widgets/appbar/custom_app_bar.dart';
import 'package:finals_fe/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NotificationPage extends ConsumerWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Notifikasi',
        onBack: () {
          context.pop();
        },
        trailling: GestureDetector(
          onTap: () async {},
          child: SizedBox(
            height: 20,
            child: Text(
              'Tandai Sudah dibaca (0)',
              style: GoogleFonts.montserrat(
                color: AppColor.lightBlue,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: Align(
          alignment: Alignment.topCenter,
          child: ListView.separated(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: const NotificationCard(),
              );
            },
            separatorBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  color: AppColor.grey,
                  thickness: 0.5,
                ),
              );
            },
            itemCount: 10,
          ),
        ),
      ),
    );
  }
}
