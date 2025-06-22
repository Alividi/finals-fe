import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'ticket_detail_model.freezed.dart';
part 'ticket_detail_model.g.dart';

TicketDetailModel ticketDetailModelFromJson(String str) =>
    TicketDetailModel.fromJson(json.decode(str));

String ticketDetailModelToJson(TicketDetailModel data) => json.encode(data.toJson());

@freezed
abstract class TicketDetailModel with _$TicketDetailModel {
  const factory TicketDetailModel({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "status") String? status,
    @JsonKey(name: "nomor_tiket") String? nomorTiket,
    @JsonKey(name: "nama_service") String? namaService,
    @JsonKey(name: "ip_kit") String? ipKit,
    @JsonKey(name: "kit_sn") String? kitSn,
    @JsonKey(name: "ssid") String? ssid,
    @JsonKey(name: "nama_perusahaan") String? namaPerusahaan,
    @JsonKey(name: "nama_teknisi") dynamic namaTeknisi,
    @JsonKey(name: "address_line") String? addressLine,
    @JsonKey(name: "nama_gangguan") String? namaGangguan,
    @JsonKey(name: "created_at") DateTime? createdAt,
  }) = _TicketDetailModel;

  factory TicketDetailModel.fromJson(Map<String, dynamic> json) =>
      _$TicketDetailModelFromJson(json);
}
