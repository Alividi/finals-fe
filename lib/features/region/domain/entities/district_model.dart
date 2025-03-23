// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'district_model.freezed.dart';
part 'district_model.g.dart';

@freezed
class DistrictModel with _$DistrictModel {
  const factory DistrictModel({
    @JsonKey(name: "id") String? id,
    @JsonKey(name: "regency_id") String? regencyId,
    @JsonKey(name: "name") String? name,
  }) = _DistrictModel;

  factory DistrictModel.fromJson(Map<String, dynamic> json) => _$DistrictModelFromJson(json);
}
