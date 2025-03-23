// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'ward_model.freezed.dart';
part 'ward_model.g.dart';

@freezed
class WardModel with _$WardModel {
  const factory WardModel({
    @JsonKey(name: "id") String? id,
    @JsonKey(name: "district_id") String? districtId,
    @JsonKey(name: "name") String? name,
  }) = _WardModel;

  factory WardModel.fromJson(Map<String, dynamic> json) => _$WardModelFromJson(json);
}
