import 'package:finals_fe/extensions/build_context.ext.dart';
import 'package:finals_fe/features/service/controllers/service_controllers.dart';
import 'package:finals_fe/features/service/widgets/detail_customer_for_services_widget.dart';
import 'package:finals_fe/features/service/widgets/service_statistic_widget.dart';
import 'package:finals_fe/helpers/widgets/appbar/custom_app_bar_detail_service.dart';
import 'package:finals_fe/helpers/widgets/buttons/buttons.dart';
import 'package:finals_fe/routers/router_name.dart';
import 'package:finals_fe/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ServiceDetailPage extends StatefulHookConsumerWidget {
  final int serviceId;
  const ServiceDetailPage({super.key, required this.serviceId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ServiceDetailPageState();
}

class _ServiceDetailPageState extends ConsumerState<ServiceDetailPage>
    with SingleTickerProviderStateMixin {
  final List<Tab> _tabs = const [
    Tab(text: 'Detail Pelanggan'),
    Tab(text: 'Statistik'),
  ];

  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
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
    final serviceAsync = ref.watch(getServiceByIdProvider(widget.serviceId));

    return Scaffold(
      appBar: CustomAppBarDetailService(
        title: 'Detail Layanan',
        onBack: () => context.pop(),
      ),
      body: serviceAsync.when(
        data: (service) {
          final status = switch (service.active) {
            1 => 'up',
            2 => 'down',
            0 => 'inactive',
            _ => 'unknown',
          };

          final statusColor = switch (status) {
            'up' => const Color(0xFF8CC243),
            'down' => const Color(0xFFF2075A),
            'inactive' => const Color(0xFF6E6B7F),
            _ => const Color(0xFF6E6B7F),
          };

          final dataUsageMB = service.dataUsage ?? 0.0;
          final usageInGB = dataUsageMB / 1024;
          final latitude = service.latitude ?? 0.0;
          final longitude = service.longitude ?? 0.0;
          final isDisrupt = service.isProblem ?? false;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.circle, size: 21, color: statusColor),
                    const Gap(8),
                    SizedBox(
                      width: context.deviceWidth * 0.8,
                      child: Text(
                        service.namaService ?? 'Nama Layanan',
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
                const Gap(20),

                /// Data Usage
                Container(
                  width: double.infinity,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: const Color(0xFF242134),
                    borderRadius: BorderRadius.circular(10.08),
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${usageInGB.toStringAsFixed(2)} GB',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                height: 0.9,
                                fontFamily: GoogleFonts.montserrat().fontFamily,
                              ),
                            ),
                            const Gap(3),
                            Text(
                              '/',
                              style: TextStyle(color: Colors.white, fontSize: 8),
                            ),
                            const Gap(3),
                            Text(
                              '10 GB',
                              style: TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ],
                        ),
                        const Gap(12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4.03),
                          child: LinearProgressIndicator(
                            minHeight: 8,
                            value: usageInGB > 0 ? (usageInGB / 10).clamp(0.0, 1.0) : 0.0,
                            backgroundColor: const Color(0xFF263D51),
                            valueColor: const AlwaysStoppedAnimation(Color(0xFF8158F4)),
                          ),
                        ),
                        if (usageInGB > 10) ...[
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
                        ]
                      ],
                    ),
                  ),
                ),

                /// Disruption Warning
                if (isDisrupt) ...[
                  const Gap(20),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFF242134),
                      borderRadius: BorderRadius.circular(10.08),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.warning, size: 16, color: Color(0xFFFD6464)),
                              const Gap(8),
                              Expanded(
                                child: Text(
                                  'Layanan Anda sedang mengalami gangguan',
                                  style: TextStyle(
                                    color: const Color(0xFFFD6464),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: GoogleFonts.montserrat().fontFamily,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Gap(20),
                          Button.filled(
                            onPressed: () => context.pushNamed(RouteName.troubleshoot, extra: {
                              'gangguanId': service.gangguanId ?? 0,
                              'serviceId': service.id ?? 0,
                            }),
                            label: 'Lakukan Troubleshoot',
                            color: AppColor.red,
                            height: 32,
                            fontSize: 12,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],

                /// Map
                const Gap(20),
                SizedBox(
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(latitude, longitude),
                        zoom: 14,
                      ),
                      markers: {
                        Marker(
                          markerId: const MarkerId('nodelinkLocation'),
                          position: LatLng(latitude, longitude),
                        ),
                      },
                    ),
                  ),
                ),
                const Gap(16),
                Text('Latitude: $latitude',
                    style: GoogleFonts.montserrat(
                      color: const Color(0xFF6E6B7F),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    )),
                Text('Longitude: $longitude',
                    style: GoogleFonts.montserrat(
                      color: const Color(0xFF6E6B7F),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    )),
                const Gap(16),

                /// Coordinate Button
                ElevatedButton(
                  onPressed: () {
                    context.pushNamed(
                      RouteName.serviceMap,
                      extra: {
                        'latitude': latitude,
                        'longitude': longitude,
                        'snKit': service.kitSn ?? '',
                        'mNodelinkId': service.id ?? 0,
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
                    children: [
                      Text(
                        'Ubah Titik Koordinat',
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Gap(10),
                      const Icon(Icons.edit_outlined, color: Colors.white, size: 21),
                    ],
                  ),
                ),
                const Gap(8),
                Text(
                  '* mohon tunggu perubahan titik koordinat maksimal 12 jam setelah mengubah titik koordinat',
                  style: GoogleFonts.montserrat(
                    color: const Color(0xFF6E6B7F),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const Gap(28),

                /// Tabs
                TabBar(
                  tabs: _tabs,
                  controller: _tabController,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white,
                  indicatorColor: AppColor.lightPurple,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 14),
                  dividerColor: Colors.transparent,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: _tabController.index == 0 ? 725 : 1700,
                  ),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      DetailCustomerForServicesWidget(data: service),
                      ServiceStatisticWidget(
                        selectedInterval: selectedInterval,
                        serviceId: widget.serviceId,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Gagal memuat data: $e')),
      ),
    );
  }
}
