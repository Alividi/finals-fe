import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class ServiceCardWidget extends StatelessWidget {
  final void Function() onTap;
  final String nama;
  final String alamat;
  final String status;
  final double dataUsage;
  final String aktifSejak;
  final num maxUsage;
  const ServiceCardWidget({
    super.key,
    required this.onTap,
    required this.nama,
    required this.alamat,
    required this.status,
    required this.dataUsage,
    required this.aktifSejak,
    required this.maxUsage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: const Color(0xFF242134),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.08),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 230,
                              child: Text(
                                nama,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: GoogleFonts.montserrat().fontFamily,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const Gap(6),
                            SizedBox(
                              width: 230,
                              child: Text(
                                alamat,
                                style: TextStyle(
                                  color: const Color(0xFFB094EF),
                                  fontSize: 10,
                                  fontFamily: GoogleFonts.montserrat().fontFamily,
                                  fontWeight: FontWeight.w400,
                                ),
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16.13, vertical: 6.05),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            gradient: LinearGradient(
                              begin: const Alignment(-0.00, -1.00),
                              end: const Alignment(0, 1),
                              colors: status == 'up'
                                  ? [
                                      const Color(0xFF8CC243),
                                      const Color.fromARGB(255, 143, 197, 74)
                                    ]
                                  : status == 'down'
                                      ? [const Color(0xFFF2075A), const Color(0xFFF0296F)]
                                      : [const Color(0xFF6E6B7F), const Color(0xFF6E6B7F)],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.03),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                status == 'up'
                                    ? 'Online'
                                    : status == 'down'
                                        ? 'Offline'
                                        : status == 'inactive'
                                            ? 'Inactive'
                                            : 'Unknown',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 9.89,
                                  fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Gap(12),
                    Text(
                      'Data Usage',
                      style: TextStyle(
                        color: const Color(0xFF6E6B7F),
                        fontSize: 12,
                        fontFamily: GoogleFonts.montserrat().fontFamily,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Gap(5),
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${dataUsage.toStringAsFixed(2)} GB',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: GoogleFonts.montserrat().fontFamily,
                                fontWeight: FontWeight.w700,
                                height: 0.9,
                              ),
                            ),
                            const Gap(3),
                            Text(
                              '/',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontFamily: GoogleFonts.montserrat().fontFamily,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const Gap(3),
                            Text(
                              '$maxUsage GB',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontFamily: GoogleFonts.montserrat().fontFamily,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        const Gap(12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4.03),
                          child: LinearProgressIndicator(
                            minHeight: 8,
                            value: (dataUsage == 0.0 && maxUsage == 0.0)
                                ? 0.0
                                : maxUsage == 0.0
                                    ? dataUsage / dataUsage
                                    : dataUsage / maxUsage,
                            backgroundColor: const Color(0xFF263D51),
                            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF8158F4)),
                          ),
                        ),
                        if (dataUsage > maxUsage) ...[
                          const Gap(8),
                          Row(
                            children: [
                              const Icon(Icons.warning, color: Color(0xFFFD6464), size: 12),
                              const Gap(4),
                              Text(
                                'Penggunaan Anda telah melebihi batas FUP',
                                style: TextStyle(
                                  color: const Color(0xFFFD6464),
                                  fontSize: 10,
                                  fontFamily: GoogleFonts.montserrat().fontFamily,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                    const Gap(30),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                decoration: const BoxDecoration(
                  color: Color(0xFF3399FE),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.08),
                    bottomRight: Radius.circular(10.08),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Aktif sejak $aktifSejak',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontFamily: GoogleFonts.montserrat().fontFamily,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
