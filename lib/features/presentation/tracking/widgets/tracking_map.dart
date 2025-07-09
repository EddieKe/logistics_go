import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackingMap extends StatelessWidget {
  final Set<Marker> markers;
  final Polyline polyline;

  const TrackingMap({super.key, required this.markers, required this.polyline});

  @override
  Widget build(BuildContext context) {
    final Completer<GoogleMapController> mapController = Completer();

    final LatLngBounds bounds = _createBounds(polyline.points);
    // Manually calculate the center of the bounds
    final LatLng center = LatLng(
      (bounds.southwest.latitude + bounds.northeast.latitude) / 2,
      (bounds.southwest.longitude + bounds.northeast.longitude) / 2,
    );

    return GoogleMap(
      initialCameraPosition: CameraPosition(target: center, zoom: 5), // Use the calculated center
      markers: markers,
      polylines: {polyline},
      onMapCreated: (GoogleMapController controller) {
        mapController.complete(controller);
        // Animate camera to fit the bounds after a short delay
        Future.delayed(const Duration(milliseconds: 250), () {
          controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50.0));
        });
      },
    );
  }

  LatLngBounds _createBounds(List<LatLng> points) {
    // This logic remains the same
    return LatLngBounds(
      southwest: LatLng(
        points.first.latitude < points.last.latitude ? points.first.latitude : points.last.latitude,
        points.first.longitude < points.last.longitude ? points.first.longitude : points.last.longitude,
      ),
      northeast: LatLng(
        points.first.latitude > points.last.latitude ? points.first.latitude : points.last.latitude,
        points.first.longitude > points.last.longitude ? points.first.longitude : points.last.longitude,
      ),
    );
  }
}