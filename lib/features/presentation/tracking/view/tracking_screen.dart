import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/di/shipment_di.dart';
import '../bloc/tracking_bloc.dart';
import '../widgets/shipment_details_panel.dart';
import '../widgets/tracking_app_bar.dart';
import '../widgets/tracking_map.dart';

class TrackingScreen extends StatelessWidget {
  final String shipmentId;
  const TrackingScreen({super.key, required this.shipmentId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TrackingBloc>()..add(LoadShipmentDetails(shipmentId: shipmentId)),
      child: Scaffold(
        body: BlocBuilder<TrackingBloc, TrackingState>(
          builder: (context, state) {
            if (state is TrackingLoading || state is TrackingInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is TrackingError) {
              return Center(child: Text(state.message));
            }
            if (state is TrackingLoaded) {
              return Stack(
                children: [
                  TrackingMap(
                    markers: state.markers,
                    polyline: state.polyline,
                  ),
                  const TrackingAppBar(),
                  ShipmentDetailsPanel(shipment: state.shipment),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}