import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'technicians_model.freezed.dart';
part 'technicians_model.g.dart';

TechniciansModel techniciansModelFromJson(String str) =>
    TechniciansModel.fromJson(json.decode(str));

String techniciansModelToJson(TechniciansModel data) => json.encode(data.toJson());

@freezed
abstract class TechniciansModel with _$TechniciansModel {
  const factory TechniciansModel({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "nama") String? nama,
    @JsonKey(name: "email") String? email,
    @JsonKey(name: "no_telp") String? noTelp,
    @JsonKey(name: "status") String? status,
    @JsonKey(name: "base") String? base,
  }) = _TechniciansModel;

  factory TechniciansModel.fromJson(Map<String, dynamic> json) => _$TechniciansModelFromJson(json);
}
