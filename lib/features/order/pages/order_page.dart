import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OrderPage extends HookConsumerWidget {
  const OrderPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      backgroundColor: Color(0xFF0F1323),
      body: Center(
        child: Text('Order Page'),
      ),
    );
  }
}
