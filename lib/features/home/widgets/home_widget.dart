import 'package:finals_fe/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
    required this.tabController,
    required this.type,
  });

  final TabController tabController;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 318,
      height: 310,
      padding: const EdgeInsets.all(20),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: const Color(0xFF242134),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            controller: tabController,
            dividerColor: Colors.transparent,
            indicatorColor: AppColor.lightPurple,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 3,
            labelStyle: GoogleFonts.montserrat(
              color: const Color(0xFFB094EF),
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            tabs: const [
              Tab(text: 'Semua'),
              Tab(text: 'Offline'),
              Tab(text: 'Online'),
            ],
          ),
          const Gap(20),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                _buildStaticContent("Semua"),
                _buildStaticContent("Offline"),
                _buildStaticContent("Online"),
              ],
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Lihat Semua',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: GoogleFonts.montserrat().fontFamily,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStaticContent(String category) {
    return Center(
      child: Text(
        'Contoh Data untuk $category',
        style: TextStyle(
          color: const Color(0xFFADADAD),
          fontSize: 14,
          fontFamily: GoogleFonts.montserrat().fontFamily,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
