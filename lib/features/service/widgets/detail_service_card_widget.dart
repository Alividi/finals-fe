import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailServiceCardWidget extends StatelessWidget {
  final String title;
  final String value;
  const DetailServiceCardWidget({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 16),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFF242134)),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: const Color(0xFF6E6B7F),
              fontSize: 12,
              fontFamily: GoogleFonts.montserrat().fontFamily,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: const Color(0xFFFCFCFC),
              fontSize: 16,
              fontFamily: GoogleFonts.montserrat().fontFamily,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
