import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'services_model.freezed.dart';
part 'services_model.g.dart';

ServicesModel servicesModelFromJson(String str) => ServicesModel.fromJson(json.decode(str));

String servicesModelToJson(ServicesModel data) => json.encode(data.toJson());

@freezed
abstract class ServicesModel with _$ServicesModel {
  const factory ServicesModel({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "nama_service") String? namaService,
    @JsonKey(name: "address_line") String? addressLine,
    @JsonKey(name: "active") int? active,
    @JsonKey(name: "data_usage") double? dataUsage,
    @JsonKey(name: "activation_date") DateTime? activationDate,
    @JsonKey(name: "is_problem") bool? isProblem,
  }) = _ServicesModel;

  factory ServicesModel.fromJson(Map<String, dynamic> json) => _$ServicesModelFromJson(json);
}
