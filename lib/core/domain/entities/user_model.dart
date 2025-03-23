// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "nama_perusahaan") String? namaPerusahaan,
    @JsonKey(name: "email_perusahaan") String? emailPerusahaan,
    @JsonKey(name: "no_telp_perusahaan") String? noTelpPerusahaan,
    @JsonKey(name: "npwp_perusahaan") String? npwpPerusahaan,
    @JsonKey(name: "username") String? username,
    @JsonKey(name: "password") String? password,
    @JsonKey(name: "alamat") String? alamat,
    @JsonKey(name: "provinsi_id") String? provinsiId,
    @JsonKey(name: "kota_id") String? kotaId,
    @JsonKey(name: "kecamatan_id") String? kecamatanId,
    @JsonKey(name: "kelurahan_id") String? kelurahanId,
    @JsonKey(name: "latitude") String? latitude,
    @JsonKey(name: "longitude") String? longitude,
    @JsonKey(name: "email_verified_at") DateTime? emailVerifiedAt,
    @JsonKey(name: "otp_code") String? otpCode,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}
