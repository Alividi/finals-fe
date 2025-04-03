import 'package:finals_fe/helpers/widgets/appbar/custom_app_bar.dart';
import 'package:finals_fe/helpers/widgets/buttons/buttons.dart';
import 'package:finals_fe/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class BaFormPage extends HookConsumerWidget {
  const BaFormPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageDevice = useState<File?>(null);
    final imageSpeedtest = useState<File?>(null);
    final additionalImages = useState<List<File?>>([]);
    final additionalCosts = useState<List<TextEditingController>>([]);
    final additionalCostControllers = useState<List<TextEditingController>>([]);

    void addAdditionalField() {
      if (additionalImages.value.length < 5) {
        additionalImages.value = [...additionalImages.value, null];
        additionalCosts.value = [...additionalCosts.value, TextEditingController()];
        additionalCostControllers.value = [
          ...additionalCostControllers.value,
          TextEditingController()
        ];
      }
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Form BA',
        onBack: () {
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
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
                const Text(
                  'Poto perangkat',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Gap(16),
                _buildImagePicker(imageDevice),
                const Gap(20),
                const Text(
                  'Poto Speedtest',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Gap(16),
                _buildImagePicker(imageSpeedtest),
                const Gap(20),
                for (int i = 0; i < additionalImages.value.length; i++) ...[
                  Text(
                    'Jenis Biaya ${i + 1}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const Gap(8),
                  TextField(
                    controller: additionalCostControllers.value[i],
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: 'Masukkan jenis biaya..',
                      hintStyle: const TextStyle(color: AppColor.lightGrey),
                    ),
                  ),
                  const Gap(16),
                  Text(
                    'Biaya Lainnya ${i + 1}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const Gap(8),
                  TextField(
                    controller: additionalCosts.value[i],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: 'Masukkan biaya...',
                      hintStyle: const TextStyle(color: AppColor.lightGrey),
                    ),
                  ),
                  const Gap(16),
                  const Text(
                    'Poto Lampiran',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const Gap(16),
                  _buildImagePickerHook(additionalImages, i),
                  const Gap(20),
                ],
                if (additionalImages.value.length < 5) ...[
                  Button.outlined(
                    onPressed: addAdditionalField,
                    label: 'Tambah Biaya lainnya',
                    borderColor: AppColor.lightGrey,
                  ),
                  const Gap(20),
                ],
                const Text(
                  'Penjelasan Masalah',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Gap(16),
                TextField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: 'Masukkan penjelasan masalah...',
                    hintStyle: const TextStyle(color: AppColor.lightGrey),
                  ),
                ),
                const Gap(24),
                Button.filled(onPressed: () {}, label: 'Kirim Berita Acara')
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker(ValueNotifier<File?> imageState) {
    return GestureDetector(
      onTap: () async {
        final picker = ImagePicker();
        final pickedFile = await picker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          imageState.value = File(pickedFile.path);
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: double.infinity,
          height: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColor.lightGrey),
          ),
          child: imageState.value != null
              ? Image.file(imageState.value!, fit: BoxFit.cover)
              : const Center(
                  child: Icon(Icons.camera_alt, size: 40, color: Colors.grey),
                ),
        ),
      ),
    );
  }

  Widget _buildImagePickerHook(ValueNotifier<List<File?>> imageList, int index) {
    return GestureDetector(
      onTap: () async {
        final picker = ImagePicker();
        final pickedFile = await picker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          final newList = List<File?>.from(imageList.value);
          newList[index] = File(pickedFile.path);
          imageList.value = newList;
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: double.infinity,
          height: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColor.lightGrey),
          ),
          child: imageList.value[index] != null
              ? Image.file(imageList.value[index]!, fit: BoxFit.cover)
              : const Center(
                  child: Icon(Icons.camera_alt, size: 40, color: Colors.grey),
                ),
        ),
      ),
    );
  }
}
