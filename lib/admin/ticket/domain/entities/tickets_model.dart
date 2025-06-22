import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'tickets_model.freezed.dart';
part 'tickets_model.g.dart';

TicketsModel ticketsModelFromJson(String str) => TicketsModel.fromJson(json.decode(str));

String ticketsModelToJson(TicketsModel data) => json.encode(data.toJson());

@freezed
abstract class TicketsModel with _$TicketsModel {
  const factory TicketsModel({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "status") String? status,
    @JsonKey(name: "nomor_tiket") String? nomorTiket,
    @JsonKey(name: "nama_service") String? namaService,
    @JsonKey(name: "nama_perusahaan") String? namaPerusahaan,
    @JsonKey(name: "nama_teknisi") String? namaTeknisi,
    @JsonKey(name: "address_line") String? addressLine,
    @JsonKey(name: "nama_gangguan") String? namaGangguan,
    @JsonKey(name: "created_at") DateTime? createdAt,
  }) = _TicketsModel;

  factory TicketsModel.fromJson(Map<String, dynamic> json) => _$TicketsModelFromJson(json);
}
