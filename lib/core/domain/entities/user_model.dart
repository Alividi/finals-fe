import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    @JsonKey(name: "id") int? userId,
    @JsonKey(name: "role") String? role,
    @JsonKey(name: "username") String? username,
    @JsonKey(name: "phone") String? phone,
    @JsonKey(name: "email") String? email,
    @JsonKey(name: "address") Address? address,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}

@freezed
abstract class Address with _$Address {
  const factory Address({
    @JsonKey(name: "Provinsi") String? provinsi,
    @JsonKey(name: "Kabupaten") String? kabupaten,
    @JsonKey(name: "Kecamatan") String? kecamatan,
    @JsonKey(name: "Kelurahan") String? kelurahan,
    @JsonKey(name: "RT") String? rt,
    @JsonKey(name: "RW") String? rw,
    @JsonKey(name: "Alamat") String? alamat,
    @JsonKey(name: "Latitude") double? latitude,
    @JsonKey(name: "Longitude") double? longitude,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
}
