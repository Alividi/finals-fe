// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'province_model.freezed.dart';
part 'province_model.g.dart';

@freezed
class ProvinceModel with _$ProvinceModel {
  const factory ProvinceModel({
    @JsonKey(name: "id") String? id,
    @JsonKey(name: "name") String? name,
  }) = _ProvinceModel;

  factory ProvinceModel.fromJson(Map<String, dynamic> json) => _$ProvinceModelFromJson(json);
}
