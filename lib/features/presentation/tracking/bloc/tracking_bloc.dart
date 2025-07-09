import 'dart:ui' as ui; 
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../domain/entites/shipment_entity.dart';
import '../../../domain/use_cases/get_shipment_details.dart';

part 'tracking_event.dart';
part 'tracking_state.dart';

class TrackingBloc extends Bloc<TrackingEvent, TrackingState> {
  final GetShipmentDetails getShipmentDetails;

  TrackingBloc({required this.getShipmentDetails}) : super(TrackingInitial()) {
    on<LoadShipmentDetails>(_onLoadShipmentDetails);
  }

  Future<void> _onLoadShipmentDetails(
    LoadShipmentDetails event,
    Emitter<TrackingState> emit,
  ) async {
    emit(TrackingLoading());
    final failureOrShipment = await getShipmentDetails(event.shipmentId);

    await failureOrShipment.fold(
      (failure) async => emit(TrackingError(message: failure.message)),
      (shipment) async {
        // --- Map Data Processing ---
        final originLatLng = _getLatLngForLocation(shipment.origin);
        final destinationLatLng = _getLatLngForLocation(shipment.destination);

        final markers = await _createMarkers(originLatLng, destinationLatLng);

        final polyline = Polyline(
          polylineId: const PolylineId('shipment_route'),
          points: [originLatLng, destinationLatLng],
          color: AppColors.primary,
          width: 5,
        );

        emit(TrackingLoaded(
          shipment: shipment,
          markers: markers,
          polyline: polyline,
        ));
      },
    );
  }

  // Helper to get LatLng from location string (MOCK)
  LatLng _getLatLngForLocation(String location) {
    if (location.contains('Nairobi')) return const LatLng(-1.2921, 36.8219);
    if (location.contains('Dubai')) return const LatLng(25.276987, 55.296249);
    if (location.contains('Shanghai')) return const LatLng(31.2304, 121.4737);
    if (location.contains('London')) return const LatLng(51.5072, -0.1276);
    // Removed old, unused locations to keep it clean
    return const LatLng(0, 0); // Default fallback
  }

  // Helper to create custom markers
  Future<Set<Marker>> _createMarkers(LatLng origin, LatLng destination) async {
    final Set<Marker> markers = {};

    final Uint8List originIcon = await _getBytesFromAsset('assets/icons/origin_marker.png', 100);
    final Uint8List destinationIcon = await _getBytesFromAsset('assets/icons/destination_marker.png', 100);

    markers.add(Marker(
      markerId: const MarkerId('origin'),
      position: origin,
      icon: BitmapDescriptor.fromBytes(originIcon),
    ));

    markers.add(Marker(
      markerId: const MarkerId('destination'),
      position: destination,
      icon: BitmapDescriptor.fromBytes(destinationIcon),
    ));

    return markers;
  }

  Future<Uint8List> _getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }
}