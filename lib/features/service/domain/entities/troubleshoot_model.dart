import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'troubleshoot_model.freezed.dart';
part 'troubleshoot_model.g.dart';

TroubleshootModel troubleshootModelFromJson(String str) =>
    TroubleshootModel.fromJson(json.decode(str));

String troubleshootModelToJson(TroubleshootModel data) => json.encode(data.toJson());

@freezed
abstract class TroubleshootModel with _$TroubleshootModel {
  const factory TroubleshootModel({
    @JsonKey(name: "gangguan_id") int? gangguanId,
    @JsonKey(name: "nama_gangguan") String? namaGangguan,
    @JsonKey(name: "deskripsi_gangguan") String? deskripsiGangguan,
    @JsonKey(name: "steps") List<Step>? steps,
  }) = _TroubleshootModel;

  factory TroubleshootModel.fromJson(Map<String, dynamic> json) =>
      _$TroubleshootModelFromJson(json);
}

@freezed
abstract class Step with _$Step {
  const factory Step({
    @JsonKey(name: "step_id") int? stepId,
    @JsonKey(name: "step") String? step,
    @JsonKey(name: "step_number") int? stepNumber,
    @JsonKey(name: "substeps") List<Substep>? substeps,
  }) = _Step;

  factory Step.fromJson(Map<String, dynamic> json) => _$StepFromJson(json);
}

@freezed
abstract class Substep with _$Substep {
  const factory Substep({
    @JsonKey(name: "substep_id") int? substepId,
    @JsonKey(name: "substep") String? substep,
    @JsonKey(name: "gambar") String? gambar,
    @JsonKey(name: "deskripsi") String? deskripsi,
  }) = _Substep;

  factory Substep.fromJson(Map<String, dynamic> json) => _$SubstepFromJson(json);
}
