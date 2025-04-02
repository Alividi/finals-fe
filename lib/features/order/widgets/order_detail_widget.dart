import 'package:finals_fe/extensions/build_context.ext.dart';

import 'package:finals_fe/features/order/widgets/download_file_widget.dart';
import 'package:finals_fe/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class OrderDetailWidget extends ConsumerStatefulWidget {
  final String? nama;
  final String? noTelp;
  final String? email;
  final String? alamatLengkap;
  final String? provinsi;
  final String? kabupaten;
  final String? namaPerangkat;
  final int? hargaPerangkat;
  final int? biayaAsuransi;
  final int? totalBiaya;
  final int? ppn;
  final int? depositLayanan;
  final int? totalKeseluruhan;
  const OrderDetailWidget({
    super.key,
    this.nama,
    this.noTelp,
    this.email,
    this.alamatLengkap,
    this.provinsi,
    this.kabupaten,
    this.namaPerangkat,
    this.hargaPerangkat,
    this.biayaAsuransi,
    this.totalBiaya,
    this.ppn,
    this.depositLayanan,
    this.totalKeseluruhan,
  });

  @override
  _ResumeOrderPageState createState() => _ResumeOrderPageState();
}

class _ResumeOrderPageState extends ConsumerState<OrderDetailWidget> {
  Object formatPrice(int price) {
    try {
      final format = NumberFormat("#,##0", "id_ID");
      return format.format(price);
    } catch (e) {
      return price;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Penerima',
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColor.white,
          ),
        ),
        const Gap(12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Nama',
              style: GoogleFonts.montserrat(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColor.disable,
              ),
            ),
            Text(
              widget.nama ?? '',
              style: GoogleFonts.montserrat(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColor.white,
              ),
            ),
          ],
        ),
        const Gap(12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Nomor Telepon',
              style: GoogleFonts.montserrat(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColor.disable,
              ),
            ),
            Text(
              widget.noTelp ?? '',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColor.white,
              ),
            ),
          ],
        ),
        const Gap(12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Email',
              style: GoogleFonts.montserrat(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColor.disable,
              ),
            ),
            Text(
              widget.email ?? '',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColor.white,
              ),
            ),
          ],
        ),
        const Gap(12),
        const Divider(
          thickness: 1,
          color: AppColor.white,
        ),
        const Gap(16),
        Text(
          'Detail Alamat',
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColor.white,
          ),
        ),
        const Gap(12),
        widget.alamatLengkap == null && widget.provinsi == null && widget.kabupaten == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ambil ditempat',
                    style: GoogleFonts.montserrat(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColor.disable,
                    ),
                  ),
                  const Gap(12),
                  const Divider(
                    thickness: 1,
                    color: AppColor.white,
                  ),
                  const Gap(16),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'provinsi',
                        style: GoogleFonts.montserrat(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppColor.disable,
                        ),
                      ),
                      Text(
                        widget.provinsi ?? '',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColor.white,
                        ),
                      ),
                    ],
                  ),
                  const Gap(12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Kabupaten',
                        style: GoogleFonts.montserrat(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppColor.disable,
                        ),
                      ),
                      Text(
                        widget.kabupaten ?? '',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColor.white,
                        ),
                      ),
                    ],
                  ),
                  const Gap(12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Alamat Lengkap',
                        style: GoogleFonts.montserrat(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppColor.disable,
                        ),
                      ),
                      Text(
                        widget.alamatLengkap ?? '',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColor.white,
                        ),
                      ),
                    ],
                  ),
                  const Gap(12),
                  const Divider(
                    thickness: 1,
                    color: AppColor.white,
                  ),
                  const Gap(16),
                ],
              ),
        Text(
          'Ringkasan Pembelian',
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColor.white,
          ),
        ),
        const Gap(12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Perangkat',
              style: GoogleFonts.montserrat(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColor.disable,
              ),
            ),
            Text(
              'IDR${formatPrice(widget.hargaPerangkat ?? 0)}',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColor.white,
              ),
            ),
          ],
        ),
        const Gap(5),
        Text(
          widget.namaPerangkat ?? '',
          style: GoogleFonts.montserrat(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: AppColor.purple,
          ),
        ),
        const Gap(12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Asuransi',
              style: GoogleFonts.montserrat(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColor.disable,
              ),
            ),
            Text(
              'IDR${formatPrice(widget.biayaAsuransi ?? 0)}',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColor.white,
              ),
            ),
          ],
        ),
        const Gap(12),
        const Divider(
          thickness: 1,
          color: AppColor.white,
        ),
        const Gap(16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Biaya',
              style: GoogleFonts.montserrat(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColor.disable,
              ),
            ),
            Text(
              'IDR${formatPrice(widget.totalBiaya ?? 0)}',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColor.white,
              ),
            ),
          ],
        ),
        const Gap(12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'PPN 11%',
              style: GoogleFonts.montserrat(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColor.disable,
              ),
            ),
            Text(
              'IDR${formatPrice(widget.ppn ?? 0)}',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColor.white,
              ),
            ),
          ],
        ),
        const Gap(12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Deposit Layanan',
              style: GoogleFonts.montserrat(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColor.disable,
              ),
            ),
            Text(
              'IDR${formatPrice(widget.depositLayanan ?? 0)}',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColor.white,
              ),
            ),
          ],
        ),
        const Gap(12),
        const Divider(
          thickness: 1,
          color: AppColor.white,
        ),
        const Gap(16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Keseluruhan',
              style: GoogleFonts.montserrat(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColor.disable,
              ),
            ),
            Text(
              'IDR${formatPrice(widget.totalKeseluruhan ?? 0)}',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColor.white,
              ),
            ),
          ],
        ),
        const Gap(30),
        GestureDetector(
          onTap: () async {},
          child: DownloadFileWidget(
            text: "Unduh Dokumen Pemesanan",
            width: context.deviceWidth * 1,
          ),
        ),
        const Gap(30),
      ],
    );
  }
}
