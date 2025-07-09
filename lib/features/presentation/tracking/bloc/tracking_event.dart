part of 'tracking_bloc.dart';

abstract class TrackingEvent extends Equatable {
  const TrackingEvent();

  @override
  List<Object> get props => [];
}

/// Event to load the details for a specific shipment.
class LoadShipmentDetails extends TrackingEvent {
  final String shipmentId;

  const LoadShipmentDetails({required this.shipmentId});

  @override
  List<Object> get props => [shipmentId];
}