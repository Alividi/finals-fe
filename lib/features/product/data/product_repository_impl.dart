import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:finals_fe/core/provider/dio_provider.dart';
import 'package:finals_fe/features/product/domain/entities/product_detail_model.dart';
import 'package:finals_fe/features/product/domain/entities/product_faq_model.dart';
import 'package:finals_fe/features/product/domain/entities/products_model.dart';
import 'package:finals_fe/features/product/domain/repositories/product_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_repository_impl.g.dart';

@riverpod
ProductRepository productRepository(Ref ref) {
  final httpclient = ref.watch(dioProvider);
  return ProductRepositoryImpl(httpclient: httpclient);
}

class ProductRepositoryImpl implements ProductRepository {
  final Dio httpclient;

  ProductRepositoryImpl({required this.httpclient});

  @override
  Future<Either<String, List<ProductsModel>>> getProducts() async {
    try {
      final response = await httpclient.get(
        'products',
      );
      if (response.statusCode == 200) {
        final productsList =
            (response.data['data'] as List).map((e) => ProductsModel.fromJson(e)).toList();
        return Right(productsList);
      } else {
        throw Exception('Failed to fetch products');
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'] ?? e.message;
      return Left(errorMessage);
    }
  }

  @override
  Future<Either<String, ProductDetailModel>> getProductDetail(int productId) async {
    try {
      final response = await httpclient.get(
        'products/$productId',
      );
      if (response.statusCode == 200) {
        final productDetail = ProductDetailModel.fromJson(response.data['data']);
        return Right(productDetail);
      } else {
        throw Exception('Failed to fetch product detail');
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'] ?? e.message;
      return Left(errorMessage);
    }
  }

  @override
  Future<Either<String, List<ProductFaqModel>>> getProductFaq(int kategoriProductId) async {
    try {
      final response = await httpclient.get(
        'faqs/$kategoriProductId',
      );
      if (response.statusCode == 200) {
        final faqList =
            (response.data['data'] as List).map((e) => ProductFaqModel.fromJson(e)).toList();
        return Right(faqList);
      } else {
        throw Exception('Failed to fetch product FAQs');
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'] ?? e.message;
      return Left(errorMessage);
    }
  }
}
