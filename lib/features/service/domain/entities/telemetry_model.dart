import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'telemetry_model.freezed.dart';
part 'telemetry_model.g.dart';

TelemetryModel telemetryModelFromJson(String str) => TelemetryModel.fromJson(json.decode(str));

String telemetryModelToJson(TelemetryModel data) => json.encode(data.toJson());

@freezed
abstract class TelemetryModel with _$TelemetryModel {
  const factory TelemetryModel({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "service_id") int? serviceId,
    @JsonKey(name: "ts") DateTime? ts,
    @JsonKey(name: "downlink_troughput") double? downlinkTroughput,
    @JsonKey(name: "uplink_troughput") double? uplinkTroughput,
    @JsonKey(name: "ping_drop_rate_avg") double? pingDropRateAvg,
    @JsonKey(name: "ping_latency_ms_avg") double? pingLatencyMsAvg,
    @JsonKey(name: "obstruction_percent_time") double? obstructionPercentTime,
    @JsonKey(name: "uptime") DateTime? uptime,
    @JsonKey(name: "signal_quality") double? signalQuality,
  }) = _TelemetryModel;

  factory TelemetryModel.fromJson(Map<String, dynamic> json) => _$TelemetryModelFromJson(json);
}
