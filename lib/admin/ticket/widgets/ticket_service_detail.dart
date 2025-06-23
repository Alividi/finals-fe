import 'package:finals_fe/extensions/build_context.ext.dart';
import 'package:finals_fe/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TicketServiceDetail extends StatelessWidget {
  final String? title;
  final String? value;
  const TicketServiceDetail({
    this.title,
    this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: context.deviceWidth * 0.36,
          child: Text(
            title ?? 'Title',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColor.lightGrey,
            ),
          ),
        ),
        const Text(
          ':',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColor.lightGrey,
          ),
        ),
        const Gap(12),
        Flexible(
          child: Text(
            value ?? 'Value',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColor.lightGrey,
            ),
          ),
        ),
      ],
    );
  }
}
