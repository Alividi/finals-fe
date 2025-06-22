import 'package:dartz/dartz.dart';
import 'package:finals_fe/features/product/domain/entities/product_detail_model.dart';
import 'package:finals_fe/features/product/domain/entities/product_faq_model.dart';
import 'package:finals_fe/features/product/domain/entities/products_model.dart';

abstract class ProductRepository {
  Future<Either<String, List<ProductsModel>>> getProducts();
  Future<Either<String, ProductDetailModel>> getProductDetail(int productId);
  Future<Either<String, List<ProductFaqModel>>> getProductFaq(int kategoriProductId);
}
