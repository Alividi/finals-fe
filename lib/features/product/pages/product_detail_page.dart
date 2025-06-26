import 'package:finals_fe/features/product/controllers/product_controllers.dart';
import 'package:finals_fe/features/product/widgets/expansion_custom_widget.dart';
import 'package:finals_fe/features/product/widgets/tag_device_widget.dart';
import 'package:finals_fe/features/product/widgets/tag_service_widget.dart';
import 'package:finals_fe/helpers/widgets/bottom_sheets/custom_dragable_sheet.dart';
import 'package:finals_fe/helpers/widgets/buttons/buttons.dart';
import 'package:finals_fe/utils/app_color.dart';
import 'package:finals_fe/utils/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailPage extends ConsumerWidget {
  final int productId;
  const ProductDetailPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(getProductDetailProvider(productId));

    return Scaffold(
      body: detailAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (detail) {
          final faqAsync =
              ref.watch(getProductFaqProvider(detail.perangkat![0].kategoriProdukId ?? 0));

          return Stack(
            children: [
              // --- Top Image and Back Button ---
              Positioned(
                top: 38,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Stack(
                    children: [
                      detail.image != null
                          ? Image.network(detail.image!, width: double.infinity, fit: BoxFit.cover)
                          : Container(
                              color: AppColor.darkBackground,
                              child: const Center(
                                child: Icon(Icons.broken_image, color: Colors.white, size: 50),
                              ),
                            ),
                      Positioned(
                        top: 20,
                        left: 20,
                        child: Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                            color: AppColor.blueBackground,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: IconButton(
                            icon: SvgPicture.asset(
                              Assets.icons.back.path,
                              width: 20,
                            ),
                            onPressed: () => context.pop(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // --- Draggable Sheet Content ---
              Positioned.fill(
                child: Column(
                  children: [
                    Expanded(
                      child: CustomDragableSheet(
                        child: Container(
                          color: Colors.black,
                          padding: const EdgeInsets.fromLTRB(20, 15, 22, 80),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  detail.nama ?? 'Product Name',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.white,
                                  ),
                                ),
                                const Gap(16),
                                ExpansionCustomWidget(
                                  title: 'Spesifikasi Produk',
                                  icon: Icons.info,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 16),
                                    child: Text(
                                      detail.spesifikasi ?? 'Tidak ada spesifikasi.',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const Gap(16),
                                Text(
                                  'Pilihan Perangkat',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.white,
                                  ),
                                ),
                                const Gap(10),
                                Wrap(
                                  runSpacing: 10,
                                  children: (detail.perangkat ?? []).map((device) {
                                    return TagDeviceWidget(
                                      text: device.namaProduk ?? '-',
                                      isSelected: false,
                                      onTap: () {},
                                    );
                                  }).toList(),
                                ),
                                const Gap(16),
                                Text(
                                  'Pilihan Layanan',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.white,
                                  ),
                                ),
                                const Gap(10),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: (detail.layanan ?? []).map((service) {
                                    return TagServiceWidget(
                                      text: '${service.namaLayanan} - Rp${service.hargaLayanan}',
                                      isSelected: false,
                                      onTap: () {},
                                    );
                                  }).toList(),
                                ),
                                const Gap(16),
                                Text(
                                  'Pertanyaan Umum',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.white,
                                  ),
                                ),
                                faqAsync.when(
                                  loading: () => const Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: CircularProgressIndicator(),
                                  ),
                                  error: (e, _) => Text('Gagal memuat FAQ: $e',
                                      style: TextStyle(color: Colors.red)),
                                  data: (faqs) => ListView(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    children: faqs.map((faq) {
                                      return ExpansionTile(
                                        title: Text(
                                          faq.pertanyaan ?? 'Tidak ada pertanyaan',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: AppColor.white,
                                          ),
                                        ),
                                        maintainState: true,
                                        tilePadding: EdgeInsets.zero,
                                        iconColor: AppColor.white,
                                        collapsedIconColor: AppColor.white,
                                        shape: const Border.fromBorderSide(BorderSide.none),
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                faq.jawaban ?? 'Tidak ada jawaban',
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 14,
                                                  color: AppColor.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      color: Colors.black,
                      child: Button.filled(
                        onPressed: () {},
                        label: 'Beli Sekarang',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
