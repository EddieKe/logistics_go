part of 'tracking_bloc.dart';

abstract class TrackingState extends Equatable {
  const TrackingState();

  @override
  List<Object> get props => [];
}

class TrackingInitial extends TrackingState {}

class TrackingLoading extends TrackingState {}

class TrackingLoaded extends TrackingState {
  final ShipmentEntity shipment;
  final Set<Marker> markers;
  final Polyline polyline;

  const TrackingLoaded({
    required this.shipment,
    required this.markers,
    required this.polyline,
  });

  @override
  List<Object> get props => [shipment, markers, polyline];
}

class TrackingError extends TrackingState {
  final String message;

  const TrackingError({required this.message});

  @override
  List<Object> get props => [message];
}