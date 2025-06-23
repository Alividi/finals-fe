import 'dart:developer';

import 'package:finals_fe/admin/ticket/controllers/ticket_controllers.dart';
import 'package:finals_fe/admin/ticket/domain/entities/tickets_params.dart';
import 'package:finals_fe/features/service/controllers/service_controllers.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:finals_fe/helpers/widgets/appbar/custom_app_bar.dart';
import 'package:finals_fe/helpers/widgets/buttons/buttons.dart';
import 'package:finals_fe/helpers/widgets/dialogs/confirmation_dialog.dart';
import 'package:finals_fe/utils/app_color.dart';
import 'package:finals_fe/features/troubleshoot/widgets/troubleshoot_steps.dart';

class TroubleshootPage extends HookConsumerWidget {
  final int gangguanId;
  final int serviceId;

  const TroubleshootPage({
    super.key,
    required this.gangguanId,
    required this.serviceId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final troubleshootAsync = ref.watch(getTroubleshootProvider(gangguanId));

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Troubleshoot',
        onBack: () => Navigator.pop(context),
      ),
      body: troubleshootAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (troubleshoot) {
          final steps = troubleshoot.steps ?? [];

          return Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                decoration: BoxDecoration(
                  color: AppColor.blueBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (troubleshoot.namaGangguan != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Center(
                          child: Text(
                            troubleshoot.namaGangguan!,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: AppColor.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    const Gap(20),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: steps.length,
                      itemBuilder: (context, stepIndex) {
                        final step = steps[stepIndex];
                        final substeps = step.substeps ?? [];

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: substeps.map((substep) {
                            return TroubleshootSteps(
                              step: substep == substeps.first
                                  ? 'Langkah ${step.stepNumber ?? stepIndex + 1} ${step.step ?? ''}'
                                  : null,
                              imageTitle: substep.substep,
                              imageUrl: substep.gambar,
                              imageDescription: substep.deskripsi,
                            );
                          }).toList(),
                        );
                      },
                    ),
                    const Gap(20),
                    Button.filled(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => ConfirmationDialog(
                            title: 'Ingin membuat tiket terkait gangguan?',
                            description: 'Kami akan mengirimkan teknisi ke lokasi Anda.',
                            confirmText: 'Ya',
                            cancelText: 'Tidak',
                            onConfirm: () async {
                              context.pop();

                              final result = await ref.read(createTicketProvider(
                                CreateTicketParams(serviceId: serviceId, gangguanId: gangguanId),
                              ).future);
                              log('Create Ticket Result: $result');
                              context.pop();
                            },
                            onCancel: () {
                              context.pop();
                            },
                            confirmColor: AppColor.orange,
                            borderColor: AppColor.lightGrey,
                          ),
                        );
                      },
                      label: 'Belum Selesai',
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
