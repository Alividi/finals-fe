import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'products_model.freezed.dart';
part 'products_model.g.dart';

ProductsModel productsModelFromJson(String str) => ProductsModel.fromJson(json.decode(str));

String productsModelToJson(ProductsModel data) => json.encode(data.toJson());

@freezed
abstract class ProductsModel with _$ProductsModel {
  const factory ProductsModel({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "nama") String? nama,
    @JsonKey(name: "deskripsi") String? deskripsi,
    @JsonKey(name: "image") String? image,
  }) = _ProductsModel;

  factory ProductsModel.fromJson(Map<String, dynamic> json) => _$ProductsModelFromJson(json);
}
