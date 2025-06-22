import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'product_faq_model.freezed.dart';
part 'product_faq_model.g.dart';

ProductFaqModel productFaqModelFromJson(String str) => ProductFaqModel.fromJson(json.decode(str));

String productFaqModelToJson(ProductFaqModel data) => json.encode(data.toJson());

@freezed
abstract class ProductFaqModel with _$ProductFaqModel {
  const factory ProductFaqModel({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "kategori_produk_id") int? kategoriProdukId,
    @JsonKey(name: "pertanyaan") String? pertanyaan,
    @JsonKey(name: "jawaban") String? jawaban,
  }) = _ProductFaqModel;

  factory ProductFaqModel.fromJson(Map<String, dynamic> json) => _$ProductFaqModelFromJson(json);
}
