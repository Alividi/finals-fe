import 'dart:io';

class BiayaLainnya {
  final String jenisBiaya;
  final int jumlah;
  final File lampiran;

  BiayaLainnya({
    required this.jenisBiaya,
    required this.jumlah,
    required this.lampiran,
  });
}

class CreateBaParams {
  final int ticketId;
  final String detailBa;
  final File gambarPerangkat;
  final File gambarSpeedtest;
  final List<BiayaLainnya> biayaLainnya;

  CreateBaParams({
    required this.ticketId,
    required this.detailBa,
    required this.gambarPerangkat,
    required this.gambarSpeedtest,
    required this.biayaLainnya,
  });
}
