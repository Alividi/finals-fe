import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:finals_fe/utils/app_color.dart';

class TexfieldWidget extends StatefulWidget {
  final String title;
  final bool isRequired;
  final bool isPassword;
  final TextEditingController controller;

  const TexfieldWidget({
    super.key,
    required this.title,
    required this.isRequired,
    this.isPassword = false,
    required this.controller,
  });

  @override
  _TexfieldWidgetState createState() => _TexfieldWidgetState();
}

class _TexfieldWidgetState extends State<TexfieldWidget> {
  final bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 16),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: AppColor.blueBackground),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  color: AppColor.darkPurple,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (widget.isRequired) ...[
                const Gap(4),
                const Text(
                  '*',
                  style: TextStyle(
                    color: AppColor.lightRed,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
          Padding(
            padding: EdgeInsets.zero,
            child: Expanded(
              child: TextField(
                maxLines: widget.isPassword ? 1 : null,
                obscureText: widget.isPassword ? !_isPasswordVisible : false,
                controller: widget.controller,
                style: const TextStyle(
                  color: AppColor.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  // suffixIcon: widget.isPassword
                  //     ? Padding(
                  //         padding: EdgeInsets.zero,
                  //         child: IconButton(
                  //           padding: EdgeInsets.zero,
                  //           icon: Icon(
                  //             _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  //             color: AppColor.darkPurple,
                  //           ),
                  //           onPressed: () {
                  //             setState(() {
                  //               _isPasswordVisible = !_isPasswordVisible;
                  //             });
                  //           },
                  //         ),
                  //       )
                  //     : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
