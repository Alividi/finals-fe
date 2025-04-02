import 'package:finals_fe/features/order/widgets/order_detail_widget.dart';
import 'package:finals_fe/helpers/widgets/appbar/custom_app_bar.dart';
import 'package:finals_fe/utils/app_color.dart';
import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OrderDetailPage extends StatefulHookConsumerWidget {
  const OrderDetailPage({super.key});

  @override
  ConsumerState<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends ConsumerState<OrderDetailPage>
    with SingleTickerProviderStateMixin {
  final List<Tab> _tabs = [
    const Tab(text: 'Status Order'),
    const Tab(text: 'Rincian Pesanan'),
  ];

  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Detail Order',
        onBack: () {
          context.pop();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColor.darkGrey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.image,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                const Gap(15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nama Kategori',
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColor.white,
                        ),
                      ),
                      const Gap(6),
                      Text(
                        'Pesanan dibuat tanggal -',
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColor.disable,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        'ID Pesanan: -',
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColor.disable,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TabBar(
              tabs: _tabs,
              labelStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: GoogleFonts.montserrat().fontFamily,
              ),
              controller: _tabController,
              labelColor: AppColor.white,
              indicatorColor: AppColor.purple,
              unselectedLabelColor: AppColor.lightGrey,
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  Center(child: Text('Status Order')),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          OrderDetailWidget(),
                          Gap(16),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
