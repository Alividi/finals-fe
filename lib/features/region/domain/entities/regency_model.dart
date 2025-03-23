// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'regency_model.freezed.dart';
part 'regency_model.g.dart';

@freezed
class RegencyModel with _$RegencyModel {
  const factory RegencyModel({
    @JsonKey(name: "id") String? id,
    @JsonKey(name: "province_id") String? provinceId,
    @JsonKey(name: "name") String? name,
  }) = _RegencyModel;

  factory RegencyModel.fromJson(Map<String, dynamic> json) => _$RegencyModelFromJson(json);
}
