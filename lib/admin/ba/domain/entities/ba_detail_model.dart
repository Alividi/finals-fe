import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'ba_detail_model.freezed.dart';
part 'ba_detail_model.g.dart';

BaDetailModel baDetailModelFromJson(String str) => BaDetailModel.fromJson(json.decode(str));

String baDetailModelToJson(BaDetailModel data) => json.encode(data.toJson());

@freezed
abstract class BaDetailModel with _$BaDetailModel {
  const factory BaDetailModel({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "ticket_id") int? ticketId,
    @JsonKey(name: "nomor_tiket") String? nomorTiket,
    @JsonKey(name: "gambar_perangkat") String? gambarPerangkat,
    @JsonKey(name: "gambar_speedtest") String? gambarSpeedtest,
    @JsonKey(name: "detail_ba") String? detailBa,
    @JsonKey(name: "biaya_lainnya") List<BiayaLainnya>? biayaLainnya,
  }) = _BaDetailModel;

  factory BaDetailModel.fromJson(Map<String, dynamic> json) => _$BaDetailModelFromJson(json);
}

@freezed
abstract class BiayaLainnya with _$BiayaLainnya {
  const factory BiayaLainnya({
    @JsonKey(name: "jenis_biaya") String? jenisBiaya,
    @JsonKey(name: "jumlah") int? jumlah,
    @JsonKey(name: "lampiran") String? lampiran,
  }) = _BiayaLainnya;

  factory BiayaLainnya.fromJson(Map<String, dynamic> json) => _$BiayaLainnyaFromJson(json);
}
