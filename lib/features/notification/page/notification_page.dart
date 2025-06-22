import 'dart:developer';

import 'package:finals_fe/features/notification/controllers/notification_controllers.dart';
import 'package:finals_fe/features/notification/domain/entities/notifications_params.dart';
import 'package:finals_fe/features/notification/widgets/notification_card.dart';
import 'package:finals_fe/helpers/format/text_format_helper.dart';
import 'package:finals_fe/helpers/widgets/appbar/custom_app_bar.dart';
import 'package:finals_fe/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NotificationPage extends ConsumerStatefulWidget {
  const NotificationPage({super.key});

  @override
  ConsumerState<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends ConsumerState<NotificationPage> {
  final params = NotificationsParams(page: 1, pageSize: 100);

  Future<void> _refresh() async {
    ref.invalidate(getNotificationsProvider);
    await ref.read(getNotificationsProvider(params).future);
  }

  Future<void> _markAllAsRead() async {
    try {
      await ref.read(readAllNotificationsProvider.future);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Semua notifikasi ditandai sebagai sudah dibaca')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final notificationsAsync = ref.watch(getNotificationsProvider(params));

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Notifikasi',
        onBack: () => context.pop(),
        trailling: GestureDetector(
          onTap: _markAllAsRead,
          child: SizedBox(
            height: 20,
            child: Text(
              'Tandai Sudah dibaca',
              style: GoogleFonts.montserrat(
                color: AppColor.lightBlue,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
      body: notificationsAsync.when(
        data: (data) {
          final list = data.notifications ?? [];

          if (list.isEmpty) {
            return const Center(child: Text('Tidak ada notifikasi.'));
          }

          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.separated(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              itemCount: list.length,
              itemBuilder: (context, index) {
                final item = list[index];
                return GestureDetector(
                  onTap: () async {
                    try {
                      await ref.read(readNotificationProvider(item.id!).future);
                      await _refresh();
                    } catch (e) {
                      log('Error marking notification as read: $e');
                    }
                  },
                  child: NotificationCard(
                    isRead: item.isRead ?? false,
                    title: item.judul ?? '-',
                    description: item.deskripsi ?? '-',
                    time: formatTime(item.createdAt),
                  ),
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
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Gagal memuat notifikasi: $error')),
      ),
    );
  }
}
