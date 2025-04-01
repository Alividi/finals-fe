import 'package:finals_fe/extensions/build_context.ext.dart';
import 'package:finals_fe/features/service/widgets/detail_customer_for_services_widget.dart';

import 'package:finals_fe/features/service/widgets/service_statistic_widget.dart';
import 'package:finals_fe/helpers/widgets/appbar/custom_app_bar_detail_product.dart';
import 'package:finals_fe/routers/router_name.dart';
import 'package:finals_fe/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ServiceDetailPage extends StatefulHookConsumerWidget {
  const ServiceDetailPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ServiceDetailPageState();
}

class _ServiceDetailPageState extends ConsumerState<ServiceDetailPage>
    with SingleTickerProviderStateMixin {
  final List<Tab> _tabs = [
    const Tab(
      text: 'Detail Pelanggan',
    ),
    const Tab(
      text: 'Statistik',
    ),
  ];

  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedInterval = useState('15 Menit');
    return Scaffold(
      appBar: CustomAppBarDetailProduct(
        title: 'Nama Layanan',
        onBack: () {
          context.pop();
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.circle,
                    size: 21,
                    color: AppColor.green,
                  ),
                  const Gap(8),
                  SizedBox(
                    width: context.deviceWidth * 0.8,
                    child: Text(
                      'Nama Layanan',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: GoogleFonts.montserrat().fontFamily,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(28),
              Container(
                width: double.infinity,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: const Color(0xFF242134),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.08),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Data Usage',
                        style: TextStyle(
                          color: const Color(0xFF6E6B7F),
                          fontSize: 12,
                          fontFamily: GoogleFonts.montserrat().fontFamily,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Gap(8),
                      Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '0.0 GB',
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
                                '0 GB',
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
                            child: const LinearProgressIndicator(
                              minHeight: 8,
                              value: 0.0,
                              backgroundColor: Color(0xFF263D51),
                              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF8158F4)),
                            ),
                          ),
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
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(28),
              SizedBox(
                height: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: GoogleMap(
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(-6.595038, 106.816635),
                      zoom: 14,
                    ),
                    markers: {
                      const Marker(
                        markerId: MarkerId('nodelinkLocation'),
                        position: LatLng(-6.595038, 106.816635),
                      ),
                    },
                  ),
                ),
              ),
              const Gap(16),
              Text(
                'Latitude: 0.0',
                style: TextStyle(
                  color: const Color(0xFF6E6B7F),
                  fontSize: 12,
                  fontFamily: GoogleFonts.montserrat().fontFamily,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Longitude: 0.0',
                style: TextStyle(
                  color: const Color(0xFF6E6B7F),
                  fontSize: 12,
                  fontFamily: GoogleFonts.montserrat().fontFamily,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Gap(16),
              ElevatedButton(
                onPressed: () {
                  context.pushNamed(
                    RouteName.serviceMap,
                    extra: {
                      'latitude': -6.595038,
                      'longitude': 106.816635,
                      'snKit': '1234567890',
                      'mNodelinkId': 1,
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8158F4),
                  padding: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  minimumSize: const Size(double.infinity, 52),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Ubah Titik Koordinat',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontFamily: GoogleFonts.montserrat().fontFamily,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Gap(10),
                    Container(
                      width: 21.99,
                      height: 21.99,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(),
                      child: const Icon(
                        Icons.edit_outlined,
                        color: Colors.white,
                        size: 21,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '* mohon tunggu perubahan titik koordinat maksimal 12 jam setelah mengubah titik koordinat',
                style: TextStyle(
                  color: const Color(0xFF6E6B7F),
                  fontSize: 12,
                  fontFamily: GoogleFonts.montserrat().fontFamily,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Gap(28),
              TabBar(
                tabs: _tabs,
                labelStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.montserrat().fontFamily),
                controller: _tabController,
                labelColor: Colors.white,
                indicatorColor: AppColor.lightPurple,
                unselectedLabelColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: _tabController.index == 0
                      ? 825
                      : _tabController.index == 1
                          ? 1700
                          : 825,
                ),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    const DetailCustomerForServicesWidget(),
                    ServiceStatisticWidget(selectedInterval: selectedInterval),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
