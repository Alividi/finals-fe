import 'package:finals_fe/extensions/build_context.ext.dart';
import 'package:finals_fe/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class OrderCard extends StatelessWidget {
  final int index;
  final String image;
  final int statusId;
  final String kategori;
  final int totalKeseluruhan;
  final String tanggalOrder;
  final String orderId;
  final VoidCallback onTap;

  const OrderCard({
    super.key,
    required this.image,
    required this.statusId,
    required this.kategori,
    required this.totalKeseluruhan,
    required this.tanggalOrder,
    required this.orderId,
    required this.onTap,
    required this.index,
  });

  String getStatusText(int statusId) {
    if (statusId == 1) {
      return "Belum Dibayar";
    } else if (statusId == 2) {
      return "Pesanan Diterima";
    } else if (statusId == 3 || statusId == 4 || statusId == 5 || statusId == 6 || statusId == 9) {
      return "Pesanan Diproses";
    } else if (statusId == 7) {
      return "Pesanan Selesai";
    } else if (statusId == 8) {
      return "Pesanan Dibatalkan";
    }
    return "Status Tidak Dikenal";
  }

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
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 15,
              horizontal: context.deviceWidth * 0.03,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: AppColor.blueBackground, width: 1),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: context.deviceWidth * 0.38,
                      height: 150,
                      decoration: BoxDecoration(
                        color: AppColor.darkGrey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: image != ''
                              ? Image.network(
                                  image,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    );
                                  },
                                )
                              : const Icon(
                                  Icons.error,
                                  color: Colors.red,
                                )),
                    ),
                    const Gap(15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IntrinsicWidth(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              alignment: Alignment.center,
                              height: 21,
                              decoration: BoxDecoration(
                                color: statusId == 8
                                    ? AppColor.lightRed
                                    : statusId == 7
                                        ? AppColor.green
                                        : AppColor.lightBlue,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                getStatusText(statusId),
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const Gap(6),
                          Text(
                            kategori,
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColor.white,
                            ),
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Gap(6),
                          Text(
                            'IDR${formatPrice(totalKeseluruhan)}',
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColor.white,
                            ),
                            softWrap: true,
                            overflow: TextOverflow.clip,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(6),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pesanan dibuat tanggal $tanggalOrder',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColor.lightGrey,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      'ID Pesanan: $orderId',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColor.lightGrey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
