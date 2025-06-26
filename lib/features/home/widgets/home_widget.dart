import 'package:finals_fe/features/service/domain/entities/services_model.dart';
import 'package:finals_fe/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
    required this.tabController,
    this.allService,
    this.offlineService,
    this.onlineService,
    this.isLoading = false,
    this.hasError = false,
    this.error,
    this.onTap,
  });

  final TabController tabController;
  final ServicesModel? allService;
  final ServicesModel? offlineService;
  final ServicesModel? onlineService;
  final bool isLoading;
  final bool hasError;
  final String? error;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 314,
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
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : hasError
                    ? Center(
                        child: Text(
                          error ?? 'Terjadi kesalahan',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: GoogleFonts.montserrat().fontFamily,
                          ),
                        ),
                      )
                    : TabBarView(
                        controller: tabController,
                        children: [
                          _buildServiceContent(allService),
                          _buildServiceContent(offlineService),
                          _buildServiceContent(onlineService),
                        ],
                      ),
          ),
          Center(
            child: TextButton(
              onPressed: onTap,
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

  Widget _buildServiceContent(ServicesModel? service) {
    if (service == null) {
      return Center(
        child: Text(
          'Tidak ada layanan',
          style: TextStyle(
            color: const Color(0xFFADADAD),
            fontSize: 14,
            fontFamily: GoogleFonts.montserrat().fontFamily,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    final nama = service.namaService ?? '';
    final alamat = service.addressLine ?? '';
    final status = switch (service.active) {
      1 => 'up',
      2 => 'down',
      0 => 'inactive',
      _ => 'unknown',
    };
    final dataUsageMB = service.dataUsage ?? 0.0;
    final usageInGB = dataUsageMB / 1024;

    const maxUsage = 10.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 230,
                  child: Text(
                    nama,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: GoogleFonts.montserrat().fontFamily,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Gap(6),
                SizedBox(
                  width: 230,
                  child: Text(
                    alamat,
                    style: TextStyle(
                      color: const Color(0xFFB094EF),
                      fontSize: 10,
                      fontFamily: GoogleFonts.montserrat().fontFamily,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.13, vertical: 6.05),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                gradient: LinearGradient(
                  begin: const Alignment(-0.00, -1.00),
                  end: const Alignment(0, 1),
                  colors: status == 'up'
                      ? [const Color(0xFF8CC243), const Color.fromARGB(255, 143, 197, 74)]
                      : status == 'down'
                          ? [const Color(0xFFF2075A), const Color(0xFFF0296F)]
                          : [const Color(0xFF6E6B7F), const Color(0xFF6E6B7F)],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.03),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    status == 'up'
                        ? 'Online'
                        : status == 'down'
                            ? 'Offline'
                            : status == 'inactive'
                                ? 'Inactive'
                                : 'Unknown',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 9.89,
                      fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Gap(12),
        Text(
          'Data Usage',
          style: TextStyle(
            color: const Color(0xFF6E6B7F),
            fontSize: 12,
            fontFamily: GoogleFonts.montserrat().fontFamily,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Gap(5),
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${usageInGB.toStringAsFixed(2)} GB',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: GoogleFonts.montserrat().fontFamily,
                    fontWeight: FontWeight.w700,
                    height: 0.9,
                  ),
                ),
                const Gap(3),
                Text(
                  '/',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontFamily: GoogleFonts.montserrat().fontFamily,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Gap(3),
                Text(
                  '$maxUsage GB',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontFamily: GoogleFonts.montserrat().fontFamily,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const Gap(12),
            ClipRRect(
              borderRadius: BorderRadius.circular(4.03),
              child: LinearProgressIndicator(
                minHeight: 8,
                value: (usageInGB == 0.0 && maxUsage == 0.0)
                    ? 0.0
                    : maxUsage == 0.0
                        ? usageInGB / usageInGB
                        : usageInGB / maxUsage,
                backgroundColor: const Color(0xFF263D51),
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF8158F4)),
              ),
            ),
            if (usageInGB > maxUsage) ...[
              const Gap(8),
              Row(
                children: [
                  const Icon(Icons.warning, color: Color(0xFFFD6464), size: 12),
                  const Gap(4),
                  Text(
                    'Penggunaan Anda telah melebihi batas FUP',
                    style: TextStyle(
                      color: const Color(0xFFFD6464),
                      fontSize: 10,
                      fontFamily: GoogleFonts.montserrat().fontFamily,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
        const Gap(30),
      ],
    );
  }
}
