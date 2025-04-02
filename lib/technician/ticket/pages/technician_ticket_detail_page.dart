import 'package:finals_fe/helpers/widgets/appbar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TechnicianTicketDetailPage extends HookConsumerWidget {
  const TechnicianTicketDetailPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Detail Tiket',
        onBack: () {
          Navigator.pop(context);
        },
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detail Tiket',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            // Add your ticket detail widgets here
          ],
        ),
      ),
    );
  }
}
