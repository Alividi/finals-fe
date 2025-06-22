import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'ticket_summary_model.freezed.dart';
part 'ticket_summary_model.g.dart';

TicketSummaryModel ticketSummaryModelFromJson(String str) =>
    TicketSummaryModel.fromJson(json.decode(str));

String ticketSummaryModelToJson(TicketSummaryModel data) => json.encode(data.toJson());

@freezed
abstract class TicketSummaryModel with _$TicketSummaryModel {
  const factory TicketSummaryModel({
    @JsonKey(name: "open_count") int? openCount,
    @JsonKey(name: "in_progress_count") int? inProgressCount,
    @JsonKey(name: "closed_count") int? closedCount,
    @JsonKey(name: "total_count") int? totalCount,
  }) = _TicketSummaryModel;

  factory TicketSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$TicketSummaryModelFromJson(json);
}
