import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'service_detail_model.freezed.dart';
part 'service_detail_model.g.dart';

ServiceDetailModel serviceDetailModelFromJson(String str) =>
    ServiceDetailModel.fromJson(json.decode(str));

String serviceDetailModelToJson(ServiceDetailModel data) => json.encode(data.toJson());

@freezed
abstract class ServiceDetailModel with _$ServiceDetailModel {
  const factory ServiceDetailModel({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "product_id") int? productId,
    @JsonKey(name: "customer_id") int? customerId,
    @JsonKey(name: "customer_name") String? customerName,
    @JsonKey(name: "gangguan_id") dynamic gangguanId,
    @JsonKey(name: "nama_service") String? namaService,
    @JsonKey(name: "address_line") String? addressLine,
    @JsonKey(name: "locality") String? locality,
    @JsonKey(name: "latitude") double? latitude,
    @JsonKey(name: "longitude") double? longitude,
    @JsonKey(name: "service_line_number") String? serviceLineNumber,
    @JsonKey(name: "nickname") String? nickname,
    @JsonKey(name: "active") int? active,
    @JsonKey(name: "ip_kit") String? ipKit,
    @JsonKey(name: "kit_sn") String? kitSn,
    @JsonKey(name: "ssid") String? ssid,
    @JsonKey(name: "activation_date") DateTime? activationDate,
    @JsonKey(name: "is_problem") bool? isProblem,
    @JsonKey(name: "device") String? device,
    @JsonKey(name: "data_usage") double? dataUsage,
  }) = _ServiceDetailModel;

  factory ServiceDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceDetailModelFromJson(json);
}
