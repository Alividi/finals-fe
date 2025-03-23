import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:finals_fe/helpers/widgets/buttons/buttons.dart';
import 'package:finals_fe/helpers/widgets/dropdown/dropdown_widget.dart';
import 'package:finals_fe/helpers/widgets/textfield/texfield_widget.dart';
import 'package:finals_fe/helpers/widgets/appbar/custom_app_bar.dart';
import 'package:finals_fe/helpers/widgets/textfield/textfield_white_widget.dart';

class RegistrationPage extends HookWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController namaPerusahaanController = useTextEditingController();
    final TextEditingController npwpPerusahaanController = useTextEditingController();
    final TextEditingController teleponPerusahaanController = useTextEditingController();
    final TextEditingController usernameController = useTextEditingController();
    final TextEditingController emailController = useTextEditingController();
    final TextEditingController passwordController = useTextEditingController();
    final TextEditingController detailAlamatController = useTextEditingController();

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Daftar Akun',
        onBack: () {
          context.pop();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(14),
              const Text(
                'Informasi Perusahaan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(12),
              TextfieldWhiteWidget(
                title: 'Nama Perusahaan',
                isRequired: true,
                controller: namaPerusahaanController,
              ),
              const Gap(12),
              TextfieldWhiteWidget(
                title: 'Nomor NPWP Perusahaan',
                isRequired: true,
                controller: npwpPerusahaanController,
              ),
              const Gap(12),
              TextfieldWhiteWidget(
                title: 'Nomor Telepon Perusahaan',
                isRequired: true,
                controller: teleponPerusahaanController,
              ),
              const Gap(12),
              TexfieldWidget(
                title: 'Username',
                isRequired: true,
                controller: usernameController,
              ),
              const Gap(12),
              TexfieldWidget(
                title: 'Alamat Email',
                isRequired: true,
                controller: emailController,
              ),
              const Gap(12),
              TexfieldWidget(
                title: 'Password',
                isPassword: true,
                isRequired: true,
                controller: passwordController,
              ),
              const Gap(16),
              const Text(
                'Alamat Perusahaan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(16),
              DropdownWidget(
                title: 'Provinsi',
                hint: 'Pilih Provinsi',
                isRequired: true,
                items: const ['Provinsi 1', 'Provinsi 2', 'Provinsi 3'],
                selectedItem: null,
                onChanged: (value) {},
              ),
              const Gap(12),
              DropdownWidget(
                title: 'Kabupaten / Kota',
                hint: 'Pilih Kabupaten / Kota',
                isRequired: true,
                items: const ['Kota 1', 'Kota 2', 'Kota 3'],
                selectedItem: null,
                onChanged: (value) {},
              ),
              const Gap(12),
              DropdownWidget(
                title: 'Kecamatan',
                hint: 'Pilih Kecamatan',
                isRequired: true,
                items: const ['Kecamatan 1', 'Kecamatan 2', 'Kecamatan 3'],
                selectedItem: null,
                onChanged: (value) {},
              ),
              const Gap(12),
              DropdownWidget(
                title: 'Kelurahan / Desa',
                hint: 'Pilih Kelurahan / Desa',
                isRequired: true,
                items: const ['Kelurahan 1', 'Kelurahan 2', 'Kelurahan 3'],
                selectedItem: null,
                onChanged: (value) {},
              ),
              const Gap(12),
              TexfieldWidget(
                title: 'Detail Alamat',
                isRequired: true,
                controller: detailAlamatController,
              ),
              const Gap(12),
              Container(
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(34),
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xFF9069FF),
                      Color(0xFF8258E5),
                    ],
                  ),
                ),
                child: Button.filled(
                  borderRadius: 34,
                  height: 52,
                  color: Colors.transparent,
                  disabled: true,
                  onPressed: () {},
                  label: 'Daftar',
                ),
              ),
              const Gap(12),
            ],
          ),
        ),
      ),
    );
  }
}
