import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Widget bottomTitleText(double value, TitleMeta meta) {
//   if (value < result.length) {
//     final metricValue = result[value.toInt()];
//     final timestamp = metricValue.ts ?? '';
//     final DateTime dateTime = DateTime.parse(timestamp);
//     return Transform.rotate(
//       angle: -0.8,
//       child: Row(
//         children: [
//           Text(
//             '${dateTime.hour}:${dateTime.minute}:${dateTime.second}',
//             style: TextStyle(
//                 color: Colors.white,
//                 fontFamily: GoogleFonts.montserrat().fontFamily,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w600),
//           ),
//           const SizedBox(width: 35, height: 15),
//         ],
//       ),
//     );
//   } else {
//     return Container();
//   }
// }

Widget bottomTitleText(double value, TitleMeta meta) {
  return Transform.rotate(
    angle: -0.8,
    child: Row(
      children: [
        Text(
          '00:00:00',
          style: TextStyle(
              color: Colors.white,
              fontFamily: GoogleFonts.montserrat().fontFamily,
              fontSize: 12,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(width: 35, height: 15),
      ],
    ),
  );
}

Widget leftTitleDownSpeedText(double value, TitleMeta meta) {
  switch (value.toInt()) {
    case 3:
      return Text(
        '3 Mb/S',
        style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.montserrat().fontFamily,
            fontSize: 12,
            fontWeight: FontWeight.w600),
      );
    case 6:
      return Text(
        '6 Mb/S',
        style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.montserrat().fontFamily,
            fontSize: 12,
            fontWeight: FontWeight.w600),
      );
    case 9:
      return Text(
        '9 Mb/S',
        style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.montserrat().fontFamily,
            fontSize: 12,
            fontWeight: FontWeight.w600),
      );
    case 12:
      return Text(
        '12 Mb/S',
        style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.montserrat().fontFamily,
            fontSize: 12,
            fontWeight: FontWeight.w600),
      );
    default:
      return const Text('');
  }
}

Widget leftTitleUpSpeedText(double value, TitleMeta meta) {
  switch (value.toInt()) {
    case 0.5:
      return Text(
        '0.5 Mb/S',
        style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.montserrat().fontFamily,
            fontSize: 12,
            fontWeight: FontWeight.w600),
      );
    case 1:
      return Text(
        '1 Mb/S',
        style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.montserrat().fontFamily,
            fontSize: 12,
            fontWeight: FontWeight.w600),
      );
    case 2:
      return Text(
        '2 Mb/S',
        style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.montserrat().fontFamily,
            fontSize: 12,
            fontWeight: FontWeight.w600),
      );
    case 3:
      return Text(
        '3 Mb/S',
        style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.montserrat().fontFamily,
            fontSize: 12,
            fontWeight: FontWeight.w600),
      );
    default:
      return const Text('');
  }
}

Widget leftTitlePercentageText(double value, TitleMeta meta) {
  switch (value.toInt()) {
    case 25:
      return Text(
        '25%',
        style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.montserrat().fontFamily,
            fontSize: 12,
            fontWeight: FontWeight.w600),
      );
    case 50:
      return Text(
        '50%',
        style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.montserrat().fontFamily,
            fontSize: 12,
            fontWeight: FontWeight.w600),
      );
    case 75:
      return Text(
        '75%',
        style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.montserrat().fontFamily,
            fontSize: 12,
            fontWeight: FontWeight.w600),
      );
    case 100:
      return Text(
        '100%',
        style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.montserrat().fontFamily,
            fontSize: 12,
            fontWeight: FontWeight.w600),
      );
    default:
      return const Text('');
  }
}

Widget leftTitleLatencyText(double value, TitleMeta meta) {
  switch (value.toInt()) {
    case 50:
      return Text(
        '50 ms',
        style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.montserrat().fontFamily,
            fontSize: 12,
            fontWeight: FontWeight.w600),
      );
    case 100:
      return Text(
        '100 ms',
        style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.montserrat().fontFamily,
            fontSize: 12,
            fontWeight: FontWeight.w600),
      );
    case 150:
      return Text(
        '150 ms',
        style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.montserrat().fontFamily,
            fontSize: 12,
            fontWeight: FontWeight.w600),
      );
    case 200:
      return Text(
        '200 ms',
        style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.montserrat().fontFamily,
            fontSize: 12,
            fontWeight: FontWeight.w600),
      );
    default:
      return const Text('');
  }
}
