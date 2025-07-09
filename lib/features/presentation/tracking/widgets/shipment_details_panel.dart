import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_sizes.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../domain/entites/shipment_entity.dart';

class ShipmentDetailsPanel extends StatelessWidget {
  final ShipmentEntity shipment;
  const ShipmentDetailsPanel({super.key, required this.shipment});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.35,
      minChildSize: 0.2,
      maxChildSize: 0.6,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSizes.r16),
              topRight: Radius.circular(AppSizes.r16),
            ),
            boxShadow: [
              BoxShadow(blurRadius: 10, color: Colors.black26),
            ],
          ),
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.all(AppSizes.p16),
            children: [
              _buildDragHandle(),
              const SizedBox(height: AppSizes.p16),
              Text('Shipment Details', style: AppTextStyles.heading2),
              const SizedBox(height: AppSizes.p16),
              _buildDetailRow('Shipment ID', shipment.id),
              _buildDetailRow('Status', shipment.status),
              _buildDetailRow('ETA', DateFormat.yMMMd().add_jm().format(shipment.estimatedTimeOfArrival)),
              const Divider(height: AppSizes.p32),
              Text('Progress', style: AppTextStyles.heading2),
              const SizedBox(height: AppSizes.p16),
              ...shipment.progress.map((p) => _buildProgressTile(p)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDragHandle() {
    return Center(
      child: Container(
        width: 40,
        height: 5,
        decoration: BoxDecoration(
          color: AppColors.lightGrey,
          borderRadius: BorderRadius.circular(AppSizes.r12),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.p4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.label),
          Text(value, style: AppTextStyles.bodyText.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildProgressTile(ShipmentProgress progress) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.p16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: AppColors.success, size: AppSizes.iconSizeMedium),
          const SizedBox(width: AppSizes.p12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(progress.description, style: AppTextStyles.bodyText),
                const SizedBox(height: AppSizes.p4),
                Text(
                  '${DateFormat.yMMMd().format(progress.timestamp)} at ${DateFormat.jm().format(progress.timestamp)}',
                  style: AppTextStyles.label,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}