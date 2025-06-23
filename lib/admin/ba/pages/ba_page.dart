import 'package:finals_fe/admin/ba/controllers/ba_controllers.dart';
import 'package:finals_fe/helpers/widgets/appbar/custom_app_bar.dart';
import 'package:finals_fe/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BaPage extends HookConsumerWidget {
  final int baId;
  const BaPage({super.key, required this.baId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final baDetailAsync = ref.watch(getBaDetailProvider(baId));

    return Scaffold(
      appBar: CustomAppBar(
        onBack: () => Navigator.pop(context),
        title: 'Berita Acara',
      ),
      body: baDetailAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (ba) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColor.blueBackground,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        ba.nomorTiket ?? '-',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColor.white,
                        ),
                      ),
                    ),
                    const Gap(20),
                    _buildImageSection('Poto Perangkat', ba.gambarPerangkat),
                    const SizedBox(height: 16),
                    _buildImageSection('Poto Speedtest', ba.gambarSpeedtest),
                    const SizedBox(height: 16),
                    if (ba.biayaLainnya != null)
                      for (int i = 0; i < ba.biayaLainnya!.length; i++) ...[
                        Text(
                          'Biaya lainnya ${i + 1}: ${ba.biayaLainnya![i].jenisBiaya ?? '-'}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('Biaya: Rp ${ba.biayaLainnya![i].jumlah ?? 0}'),
                        const SizedBox(height: 8),
                        _buildImageSection('Poto Lampiran', ba.biayaLainnya![i].lampiran),
                        const SizedBox(height: 16),
                      ],
                    const Text(
                      'Penjelasan Masalah:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(ba.detailBa ?? '-'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildImageSection(String label, String? image) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColor.lightGrey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: image != null && image.isNotEmpty
                ? Image.network(image, fit: BoxFit.cover)
                : const Center(
                    child: Icon(Icons.image_not_supported, size: 40, color: Colors.grey)),
          ),
        ),
      ],
    );
  }
}
