// ignore_for_file: library_private_types_in_public_api

import 'package:finals_fe/utils/app_color.dart';
import 'package:finals_fe/utils/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpansionCustomWidget extends StatefulWidget {
  final String title;
  final Widget child;
  final IconData icon;

  const ExpansionCustomWidget({
    super.key,
    required this.title,
    required this.child,
    this.icon = Icons.arrow_drop_down,
  });

  @override
  _ExpansionCustomWidgetState createState() => _ExpansionCustomWidgetState();
}

class _ExpansionCustomWidgetState extends State<ExpansionCustomWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                SvgPicture.asset(
                  _isExpanded ? Assets.icons.arrowDown.path : Assets.icons.arrowRight.path,
                  width: _isExpanded ? 10 : 18,
                  height: _isExpanded ? 10 : 18,
                  fit: BoxFit.cover,
                ),
                const Gap(10),
                Expanded(
                  child: Text(
                    widget.title,
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColor.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded) widget.child,
      ],
    );
  }
}
