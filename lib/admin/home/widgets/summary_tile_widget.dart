import 'package:finals_fe/extensions/build_context.ext.dart';
import 'package:finals_fe/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SummaryTileWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final String? title;
  final int? value;
  final Color? color;

  const SummaryTileWidget({
    super.key,
    this.onTap,
    this.title,
    this.value,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        width: context.deviceWidth * 0.25,
        height: context.deviceHeight * 0.1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color ?? AppColor.darkGrey,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title ?? 'Total',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const Gap(8),
              Text(
                value?.toString() ?? '0',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
