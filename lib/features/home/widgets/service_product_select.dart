import 'package:flutter/material.dart';

import 'service_product_card.dart';

SliverList serviceProductSelect({
  required List<String> product,
  required String? selectedProduct,
  required void Function(String object) onTap,
}) {
  selectedProduct ??= product.isNotEmpty ? product[0] : null;

  return SliverList(
    delegate: SliverChildBuilderDelegate(
      (context, index) {
        return ServiceProductCard(
          onTap: () {
            onTap(product[index]);
          },
          label: product[index],
          isSelected: product[index] == selectedProduct,
        );
      },
      childCount: product.length,
    ),
  );
}
