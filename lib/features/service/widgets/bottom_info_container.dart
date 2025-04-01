import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomInfoContainer extends StatelessWidget {
  final double latitude;
  final double longitude;
  final String snKit;
  final VoidCallback onSimpan;

  const BottomInfoContainer({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.snKit,
    required this.onSimpan,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: const Color(0xFF242134),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.08),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'KIT Serial Number',
              style: TextStyle(
                color: const Color(0xFFADADAD),
                fontSize: 12,
                fontFamily: GoogleFonts.montserrat().fontFamily,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Gap(6),
            Text(
              snKit,
              style: TextStyle(
                color: const Color(0xFFADADAD),
                fontSize: 14,
                fontFamily: GoogleFonts.montserrat().fontFamily,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Gap(20),
            Text(
              'Latitude',
              style: TextStyle(
                color: const Color(0xFFADADAD),
                fontSize: 12,
                fontFamily: GoogleFonts.montserrat().fontFamily,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Gap(6),
            Text(
              latitude.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: GoogleFonts.montserrat().fontFamily,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Gap(20),
            Text(
              'Longitude',
              style: TextStyle(
                color: const Color(0xFFADADAD),
                fontSize: 12,
                fontFamily: GoogleFonts.montserrat().fontFamily,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Gap(6),
            Text(
              longitude.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: GoogleFonts.montserrat().fontFamily,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Gap(20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onSimpan,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: const Color(0xFF8158F4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: Text(
                  'Simpan',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: GoogleFonts.montserrat().fontFamily,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
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
