import 'package:finals_fe/features/troubleshoot/widgets/troubleshoot_steps.dart';
import 'package:finals_fe/helpers/widgets/appbar/custom_app_bar.dart';
import 'package:finals_fe/helpers/widgets/buttons/buttons.dart';
import 'package:finals_fe/helpers/widgets/dialogs/confirmation_dialog.dart';
import 'package:finals_fe/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TroubleshootPage extends HookConsumerWidget {
  const TroubleshootPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Map<String, String?>> dummySteps = [
      {
        'step': 'Cek Koneksi',
        'imageTitle': 'Periksa Kabel',
        'imageUrl': 'https://picsum.photos/250?random=1',
        'imageDescription': 'Pastikan kabel terhubung dengan baik dan tidak rusak.',
      },
      {
        'step': null,
        'imageTitle': 'Matikan & Hidupkan Lagi',
        'imageUrl': 'https://picsum.photos/250?random=2',
        'imageDescription': 'Coba restart perangkat untuk menyelesaikan masalah sederhana.',
      },
      {
        'step': 'Periksa Pengaturan Jaringan',
        'imageTitle': 'Cek Wi-Fi atau Data',
        'imageUrl': 'https://picsum.photos/250?random=3',
        'imageDescription': 'Pastikan Wi-Fi atau data seluler diaktifkan dan berfungsi.',
      },
      {
        'step': null,
        'imageTitle': 'Cek Pembaruan',
        'imageUrl': 'https://picsum.photos/250?random=4',
        'imageDescription': 'Pastikan aplikasi dalam versi terbaru untuk menghindari bug.',
      },
      {
        'step': 'Hubungi Dukungan',
        'imageTitle': 'Bantuan Teknis',
        'imageUrl': 'https://picsum.photos/250?random=5',
        'imageDescription': 'Jika masalah berlanjut, hubungi tim dukungan teknis.',
      },
    ];
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Troubleshoot',
        onBack: () => Navigator.pop(context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            decoration: BoxDecoration(
              color: AppColor.blueBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Center(
                    child: Text(
                      'KIT, Router, dan Access Point Off ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColor.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const Gap(20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: dummySteps.length,
                  itemBuilder: (context, index) {
                    final stepData = dummySteps[index];

                    int visibleStepIndex = 0;
                    for (int i = 0; i <= index; i++) {
                      if (dummySteps[i]['step'] != null) {
                        visibleStepIndex++;
                      }
                    }

                    return TroubleshootSteps(
                      step: stepData['step'] != null
                          ? 'Langkah $visibleStepIndex ${stepData['step'] ?? ''}'
                          : null,
                      imageTitle: stepData['imageTitle'],
                      imageUrl: stepData['imageUrl'],
                      imageDescription: stepData['imageDescription'],
                    );
                  },
                ),
                const Gap(20),
                Button.filled(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => ConfirmationDialog(
                        title: 'Ingin membuat tiket terkait gangguan?',
                        description: 'Kami akan mengirimkan teknisi ke lokasi Anda.',
                        confirmText: 'Ya',
                        cancelText: 'Tidak',
                        onConfirm: () {},
                        onCancel: () {},
                        confirmColor: AppColor.orange,
                        borderColor: AppColor.lightGrey,
                      ),
                    );
                  },
                  label: 'Belum Selesai',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
