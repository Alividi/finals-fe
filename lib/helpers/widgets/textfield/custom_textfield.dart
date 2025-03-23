// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:finals_fe/utils/assets.gen.dart';

import '../../../utils/app_color.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final Color filled;
  final Color textColor;
  final Color labelColor;
  final bool isBorder;
  final TextInputType keyboardType;
  final bool isReadOnly;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final bool isRequired;
  final Function(String?)? validator;
  final bool isSuffix;
  final VoidCallback? suffixOnPressed;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.filled = Colors.transparent,
    this.textColor = Colors.white,
    this.labelColor = AppColor.darkPurple,
    this.isBorder = true,
    this.keyboardType = TextInputType.text,
    this.isReadOnly = false,
    this.onChanged,
    this.obscureText = false,
    this.isRequired = false,
    this.validator,
    this.isSuffix = false,
    this.suffixOnPressed,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isPassword = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: widget.isBorder ? AppColor.blueBackground : Colors.transparent,
        ),
        color: widget.filled,
      ),
      child: TextField(
        controller: widget.controller,
        readOnly: widget.isReadOnly,
        style: GoogleFonts.montserrat(
          color: widget.textColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        obscureText: widget.obscureText ? isPassword : false,
        onChanged: widget.onChanged,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          suffixIconConstraints: const BoxConstraints(
            minHeight: 24,
            minWidth: 24,
          ),
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon:
                      isPassword ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                  onPressed: () {
                    setState(
                      () {
                        isPassword = !isPassword;
                      },
                    );
                  },
                )
              : widget.isSuffix
                  ? InkWell(
                      onTap: widget.suffixOnPressed,
                      child: SvgPicture.asset(
                        Assets.icons.photoSearch.path,
                        fit: BoxFit.contain,
                      ),
                    )
                  : null,
          errorStyle: GoogleFonts.montserrat(
            color: AppColor.lightRed,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          label: Row(
            children: [
              Text(
                widget.label,
                style: GoogleFonts.montserrat(
                  color: widget.labelColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              widget.isRequired
                  ? Text(
                      ' *',
                      style: GoogleFonts.montserrat(
                        color: AppColor.lightRed,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : const SizedBox.shrink()
            ],
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(bottom: widget.obscureText ? 5 : 10, top: 10),
          filled: true,
          fillColor: widget.filled,
        ),
      ),
    );
  }
}
