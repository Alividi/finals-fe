import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'product_detail_model.freezed.dart';
part 'product_detail_model.g.dart';

ProductDetailModel productDetailModelFromJson(String str) =>
    ProductDetailModel.fromJson(json.decode(str));

String productDetailModelToJson(ProductDetailModel data) => json.encode(data.toJson());

@freezed
abstract class ProductDetailModel with _$ProductDetailModel {
  const factory ProductDetailModel({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "nama") String? nama,
    @JsonKey(name: "spesifikasi") String? spesifikasi,
    @JsonKey(name: "image") String? image,
    @JsonKey(name: "perangkat") List<Perangkat>? perangkat,
    @JsonKey(name: "layanan") List<Layanan>? layanan,
  }) = _ProductDetailModel;

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailModelFromJson(json);
}

@freezed
abstract class Layanan with _$Layanan {
  const factory Layanan({
    @JsonKey(name: "nama_layanan") String? namaLayanan,
    @JsonKey(name: "harga_layanan") int? hargaLayanan,
  }) = _Layanan;

  factory Layanan.fromJson(Map<String, dynamic> json) => _$LayananFromJson(json);
}

@freezed
abstract class Perangkat with _$Perangkat {
  const factory Perangkat({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "kategori_produk_id") int? kategoriProdukId,
    @JsonKey(name: "nama_produk") String? namaProduk,
    @JsonKey(name: "deskripsi_produk") String? deskripsiProduk,
    @JsonKey(name: "harga_produk") int? hargaProduk,
    @JsonKey(name: "gambar_produk") String? gambarProduk,
  }) = _Perangkat;

  factory Perangkat.fromJson(Map<String, dynamic> json) => _$PerangkatFromJson(json);
}
