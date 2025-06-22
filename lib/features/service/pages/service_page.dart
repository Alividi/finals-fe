import 'package:finals_fe/features/service/controllers/service_controllers.dart';
import 'package:finals_fe/features/service/domain/entities/services_params.dart';
import 'package:finals_fe/features/service/widgets/service_card_widget.dart';
import 'package:finals_fe/helpers/format/text_format_helper.dart';
import 'package:finals_fe/routers/router_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ServicePage extends HookConsumerWidget {
  const ServicePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedStatus = useState<String>('Semua');

    int? activeParam;
    switch (selectedStatus.value) {
      case 'Online':
        activeParam = 1;
        break;
      case 'Offline':
        activeParam = 2;
        break;
      case 'Inactive':
        activeParam = 0;
        break;
      default:
        activeParam = null;
    }
    final params = useMemoized(() => ServicesParams(active: activeParam), [activeParam]);
    final servicesAsyncValue = ref.watch(getServicesProvider(params));

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Layanan Saya",
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(20),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFF242134)),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Status Layanan',
                    style: TextStyle(
                      color: const Color(0xFF6E6B7F),
                      fontSize: 12,
                      fontFamily: GoogleFonts.montserrat().fontFamily,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Gap(5),
                  DropdownButton<String>(
                    value: selectedStatus.value,
                    isDense: true,
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white),
                    iconSize: 24,
                    elevation: 16,
                    dropdownColor: const Color(0xFF242134),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: GoogleFonts.montserrat().fontFamily,
                      fontWeight: FontWeight.w500,
                    ),
                    underline: Container(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        selectedStatus.value = newValue;
                      }
                    },
                    items: <String>['Semua', 'Online', 'Offline', 'Inactive']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const Gap(12),
            Expanded(
              child: servicesAsyncValue.when(
                data: (services) {
                  if (services.isEmpty) {
                    return const Center(
                      child: Text(
                        'Tidak ada layanan',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: services.length,
                    itemBuilder: (context, index) {
                      final service = services[index];
                      final status = switch (service.active) {
                        1 => 'up',
                        2 => 'down',
                        0 => 'inactive',
                        _ => 'unknown',
                      };
                      final dataUsageMB = service.dataUsage ?? 0.0;
                      final usageInGB = dataUsageMB / 1024;
                      final alamat = service.addressLine ?? 'Unknown';

                      return ServiceCardWidget(
                        nama: service.namaService ?? 'Unknown',
                        alamat: alamat,
                        status: status,
                        dataUsage: usageInGB,
                        aktifSejak:
                            formatToIndonesianDate(service.activationDate?.toIso8601String() ?? ''),
                        onTap: () {
                          context
                              .pushNamed(RouteName.serviceDetail, extra: {'serviceId': service.id});
                        },
                        maxUsage: 10,
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => Center(
                  child: Text(
                    'Error: $error',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
