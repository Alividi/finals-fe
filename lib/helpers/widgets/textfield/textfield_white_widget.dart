import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:finals_fe/utils/app_color.dart';

class TextfieldWhiteWidget extends StatelessWidget {
  final String title;
  final bool isRequired;
  final TextEditingController controller;

  const TextfieldWhiteWidget({
    super.key,
    required this.title,
    required this.isRequired,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 16),
        color: AppColor.disable,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColor.darkGrey,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (isRequired) ...[
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
              child: TextField(
                cursorColor: AppColor.darkGrey,
                controller: controller,
                style: const TextStyle(
                  color: AppColor.darkGrey,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
