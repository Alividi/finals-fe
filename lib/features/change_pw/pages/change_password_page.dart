import 'package:finals_fe/helpers/widgets/appbar/custom_app_bar.dart';
import 'package:finals_fe/helpers/widgets/buttons/buttons.dart';
import 'package:finals_fe/helpers/widgets/textfield/custom_textfield.dart';
import 'package:finals_fe/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChangePasswordPage extends HookConsumerWidget {
  const ChangePasswordPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final password = useTextEditingController();
    return Scaffold(
      appBar: CustomAppBar(
        onBack: () {
          context.pop();
        },
        title: 'Ubah Password',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Gap(16),
              CustomTextField(
                isBorder: false,
                filled: const Color(0xFF1E1E1E),
                controller: password,
                obscureText: true,
                label: 'Password lama',
                labelColor: AppColor.lightGrey,
              ),
              const Gap(12),
              CustomTextField(
                isBorder: false,
                filled: const Color(0xFF1E1E1E),
                controller: password,
                obscureText: true,
                label: 'Password baru',
                labelColor: AppColor.lightGrey,
              ),
              const Gap(12),
              CustomTextField(
                isBorder: false,
                filled: const Color(0xFF1E1E1E),
                controller: password,
                obscureText: true,
                label: 'Konfirmasi password',
                labelColor: AppColor.lightGrey,
              ),
              const Gap(20),
              Button.filled(onPressed: () {}, label: 'Ubah Password'),
            ],
          ),
        ),
      ),
    );
  }
}
