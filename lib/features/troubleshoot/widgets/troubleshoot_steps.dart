import 'package:finals_fe/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TroubleshootSteps extends StatelessWidget {
  final String? step;
  final String? imageUrl;
  final String? imageDescription;
  final String? imageTitle;
  const TroubleshootSteps({
    super.key,
    this.step,
    this.imageUrl,
    this.imageDescription,
    this.imageTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (step != null) ...[
          Text(
            step ?? 'Langkah 1',
            style: const TextStyle(
              color: AppColor.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(12),
        ],
        if (imageTitle != null) ...[
          Text(
            '- ${imageTitle ?? 'title'}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          const Gap(12),
        ],
        if (imageUrl != null) ...[
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.transparent,
              ),
              child: Image.network(
                imageUrl ?? 'https://picsum.photos/250',
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          const Gap(12),
        ],
        if (imageDescription != null) ...[
          Text(
            imageDescription ?? 'Deskripsi',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
        const Gap(20),
      ],
    );
  }
}
