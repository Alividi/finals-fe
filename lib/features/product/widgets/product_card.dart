import 'package:finals_fe/extensions/build_context.ext.dart';
import 'package:finals_fe/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final String image;
  final String description;
  final VoidCallback onTap;

  const ProductCard(
      {super.key,
      required this.onTap,
      required this.name,
      required this.image,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 16,
              horizontal: context.deviceWidth * 0.03,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: AppColor.blueBackground, width: 1),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: context.deviceWidth * 0.35,
                  height: 160,
                  decoration: BoxDecoration(
                    color: AppColor.lightGrey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
                const Gap(15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColor.white,
                        ),
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Gap(6),
                      Text(
                        "Deskripsi:",
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColor.lightGrey,
                        ),
                      ),
                      const Gap(6),
                      Text(
                        description,
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColor.lightGrey,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.clip,
                      ),
                    ],
                  ),
                ),
                const Gap(10),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColor.white,
                  size: 20,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
