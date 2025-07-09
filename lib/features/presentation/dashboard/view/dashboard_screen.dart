import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../app/di/shipment_di.dart';
import '../../../../app/navigation/app_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_sizes.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../domain/entites/shipment_entity.dart';
import '../bloc/dashboard_bloc.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Create the BLoC and add the initial event
      create: (context) => sl<DashboardBloc>()..add(LoadDashboard()),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: Text(
            'Dashboard',
            style: AppTextStyles.heading2.copyWith(color: AppColors.white),
          ),
        ),
        body: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state is DashboardLoading || state is DashboardInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is DashboardError) {
              return Center(child: Text(state.message));
            }
            if (state is DashboardLoaded) {
              return _buildDashboardUI(context, state.shipments);
            }
            return const SizedBox.shrink();
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).pushNamed(AppRouter.bookingRoute);
          },
          backgroundColor: AppColors.secondary,
          icon: const Icon(Icons.add, color: AppColors.white),
          label: Text('New Shipment', style: AppTextStyles.buttonLabel),
        ),
      ),
    );
  }

  Widget _buildDashboardUI(
    BuildContext context,
    List<ShipmentEntity> shipments,
  ) {
    // Calculate stats from the shipment list
    final stats = {
      'Active': shipments.where((s) => s.status == 'In Transit').length,
      'Completed': shipments.where((s) => s.status == 'Delivered').length,
      'Issues': shipments.where((s) => s.status == 'Issue').length,
    };

    return RefreshIndicator(
      onRefresh: () async {
        context.read<DashboardBloc>().add(LoadDashboard());
      },
      child: ListView(
        padding: const EdgeInsets.all(AppSizes.p16),
        children: [
          // Welcome Message
          Text('Hello, User', style: AppTextStyles.heading1),
          const SizedBox(height: AppSizes.p8),
          Text(
            'Here is a summary of your shipments.',
            style: AppTextStyles.bodyTextLight,
          ),
          const SizedBox(height: AppSizes.p24),

          // Stats Cards
          _buildStatsRow(stats),
          const SizedBox(height: AppSizes.p24),

          // Recent Shipments List
          Text('Recent Shipments', style: AppTextStyles.heading2),
          const SizedBox(height: AppSizes.p16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: shipments.length,
            separatorBuilder: (context, index) =>
                const SizedBox(height: AppSizes.p12),
            itemBuilder: (context, index) {
              final shipment = shipments[index];
              return _ShipmentListItem(shipment: shipment);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(Map<String, int> stats) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _StatCard(
          title: 'Active',
          value: stats['Active'].toString(),
          color: AppColors.secondary,
        ),
        _StatCard(
          title: 'Completed',
          value: stats['Completed'].toString(),
          color: AppColors.success,
        ),
        _StatCard(
          title: 'Issues',
          value: stats['Issues'].toString(),
          color: AppColors.error,
        ),
      ],
    );
  }
}

// Reusable Stat Card Widget
class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: AppColors.white,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.r12),
        ),
        margin: const EdgeInsets.symmetric(horizontal: AppSizes.p4),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: AppTextStyles.heading1.copyWith(color: color)),
              const SizedBox(height: AppSizes.p4),
              Text(title, style: AppTextStyles.label),
            ],
          ),
        ),
      ),
    );
  }
}

// Reusable Shipment List Item Widget
class _ShipmentListItem extends StatelessWidget {
  final ShipmentEntity shipment;
  const _ShipmentListItem({required this.shipment});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.r12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(
            context,
          ).pushNamed(AppRouter.trackingRoute, arguments: shipment.id);
        },
        borderRadius: BorderRadius.circular(AppSizes.r12),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    shipment.id,
                    style: AppTextStyles.heading2.copyWith(fontSize: 16),
                  ),
                  _StatusChip(status: shipment.status),
                ],
              ),
              const SizedBox(height: AppSizes.p16),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: AppColors.primary,
                    size: AppSizes.iconSizeSmall,
                  ),
                  const SizedBox(width: AppSizes.p8),
                  Expanded(
                    child: Text(
                      '${shipment.origin} to ${shipment.destination}',
                      style: AppTextStyles.bodyText,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.p8),
              Row(
                children: [
                  const Icon(
                    Icons.timer,
                    color: AppColors.primary,
                    size: AppSizes.iconSizeSmall,
                  ),
                  const SizedBox(width: AppSizes.p8),
                  Text(
                    'ETA: ${DateFormat.yMMMd().format(shipment.estimatedTimeOfArrival)}',
                    style: AppTextStyles.bodyText,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String status;
  const _StatusChip({required this.status});

  Color _getStatusColor() {
    switch (status) {
      case 'In Transit':
        return AppColors.secondary;
      case 'Delivered':
        return AppColors.success;
      case 'Issue':
        return AppColors.error;
      default:
        return AppColors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.p8,
        vertical: AppSizes.p4,
      ),
      decoration: BoxDecoration(
        color: _getStatusColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppSizes.r8),
      ),
      child: Text(
        status,
        style: AppTextStyles.label.copyWith(
          color: _getStatusColor(),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
