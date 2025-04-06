import 'package:finals_fe/helpers/widgets/appbar/custom_app_bar.dart';
import 'package:finals_fe/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BaPage extends HookConsumerWidget {
  const BaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const mockImageDevice = 'https://picsum.photos/250';
    const mockImageSpeedtest = 'https://picsum.photos/250';
    final mockAdditionalImages = ['https://picsum.photos/250', 'https://picsum.photos/250'];
    final mockAdditionalCostTypes = ['Transportasi', 'Makan'];
    final mockAdditionalCostAmounts = ['100000', '50000'];
    const mockExplanation = 'Koneksi tidak stabil karena hujan deras di daerah pelanggan.';

    return Scaffold(
      appBar: CustomAppBar(
        onBack: () => Navigator.pop(context),
        title: 'Berita Acara',
      ),
      body: Padding(
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
                const Center(
                  child: Text(
                    'TK-0001',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColor.white,
                    ),
                  ),
                ),
                const Gap(20),
                _buildImageSection('Poto Perangkat', mockImageDevice),
                const SizedBox(height: 16),
                _buildImageSection('Poto Speedtest', mockImageSpeedtest),
                const SizedBox(height: 16),
                for (int i = 0; i < mockAdditionalImages.length; i++) ...[
                  Text(
                    'Biaya lainnya ${i + 1}: ${mockAdditionalCostTypes[i]}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Biaya: Rp ${mockAdditionalCostAmounts[i]}'),
                  const SizedBox(height: 8),
                  _buildImageSection('Poto Lampiran', mockAdditionalImages[i]),
                  const SizedBox(height: 16),
                ],
                const Text(
                  'Penjelasan Masalah:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(mockExplanation),
              ],
            ),
          ),
        ),
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
            child: image != null
                ? Image.network(image, fit: BoxFit.cover)
                : const Center(
                    child: Icon(Icons.image_not_supported, size: 40, color: Colors.grey)),
          ),
        ),
      ],
    );
  }
}
