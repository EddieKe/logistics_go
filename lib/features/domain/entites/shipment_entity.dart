import 'package:equatable/equatable.dart';


class ShipmentEntity extends Equatable {
  final String id;
  final String status;
  final DateTime estimatedTimeOfArrival;
  final String origin;
  final String destination;
  final List<ShipmentProgress> progress;

  const ShipmentEntity({
    required this.id,
    required this.status,
    required this.estimatedTimeOfArrival,
    required this.origin,
    required this.destination,
    required this.progress,
  });

  @override
  List<Object?> get props => [id, status, estimatedTimeOfArrival, origin, destination, progress];
}

class ShipmentProgress extends Equatable {
  final String location;
  final String description;
  final DateTime timestamp;

  const ShipmentProgress({
    required this.location,
    required this.description,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [location, description, timestamp];
}