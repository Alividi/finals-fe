import 'package:finals_fe/features/product/data/product_repository_impl.dart';
import 'package:finals_fe/features/product/domain/entities/product_detail_model.dart';
import 'package:finals_fe/features/product/domain/entities/product_faq_model.dart';
import 'package:finals_fe/features/product/domain/entities/products_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_controllers.g.dart';

@riverpod
Future<List<ProductsModel>> getProducts(Ref ref) async {
  final productRepository = ref.watch(productRepositoryProvider);
  final result = await productRepository.getProducts();
  return result.fold((error) => throw Exception(error), (products) => products);
}

@riverpod
Future<ProductDetailModel> getProductDetail(Ref ref, int productId) async {
  final productRepository = ref.watch(productRepositoryProvider);
  final result = await productRepository.getProductDetail(productId);
  return result.fold((error) => throw Exception(error), (productDetail) => productDetail);
}

@riverpod
Future<List<ProductFaqModel>> getProductFaq(Ref ref, int kategoriProductId) async {
  final productRepository = ref.watch(productRepositoryProvider);
  final result = await productRepository.getProductFaq(kategoriProductId);
  return result.fold((error) => throw Exception(error), (productFaq) => productFaq);
}
