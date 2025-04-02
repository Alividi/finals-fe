import 'package:finals_fe/features/product/widgets/product_card.dart';
import 'package:finals_fe/routers/router_name.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductPage extends HookConsumerWidget {
  const ProductPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 40,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Product",
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(40),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ProductCard(
                    onTap: () {
                      context.pushNamed(RouteName.productDetail);
                    },
                    name: 'Product Name',
                    image: 'https://picsum.photos/250',
                    description: 'This is a product description.',
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
