import 'package:finals_fe/helpers/widgets/appbar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BaPage extends HookConsumerWidget {
  const BaPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar(
        onBack: () {},
        title: 'Berita Acara',
      ),
    );
  }
}
