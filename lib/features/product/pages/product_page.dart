import 'package:finals_fe/features/product/controllers/product_controllers.dart';
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
    final productsAsync = ref.watch(getProductsProvider);

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
              child: productsAsync.when(
                data: (products) => ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductCard(
                      onTap: () {
                        context.pushNamed(
                          RouteName.productDetail,
                          extra: {'productId': product.id},
                        );
                      },
                      name: product.nama ?? 'No Name',
                      image: product.image ?? 'https://via.placeholder.com/250',
                      description: product.deskripsi ?? 'No description',
                    );
                  },
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) => Center(
                  child: Text(
                    'Error: $err',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
