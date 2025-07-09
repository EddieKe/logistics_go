

import '../../domain/entites/shipment_entity.dart';

class ShipmentModel extends ShipmentEntity {
  const ShipmentModel({
    required super.id,
    required super.status,
    required super.estimatedTimeOfArrival,
    required super.origin,
    required super.destination,
    required super.progress,
  });

  factory ShipmentModel.fromJson(Map<String, dynamic> json) {
    return ShipmentModel(
      id: json['id'],
      status: json['status'],
      estimatedTimeOfArrival: DateTime.parse(json['estimatedTimeOfArrival']),
      origin: json['origin'],
      destination: json['destination'],
      progress: (json['progress'] as List)
          .map((item) => ShipmentProgressModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'estimatedTimeOfArrival': estimatedTimeOfArrival.toIso8601String(),
      'origin': origin,
      'destination': destination,
      'progress': progress.map((item) => (item as ShipmentProgressModel).toJson()).toList(),
    };
  }
}

class ShipmentProgressModel extends ShipmentProgress {
  const ShipmentProgressModel({
    required super.location,
    required super.description,
    required super.timestamp,
  });

  factory ShipmentProgressModel.fromJson(Map<String, dynamic> json) {
    return ShipmentProgressModel(
      location: json['location'],
      description: json['description'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location,
      'description': description,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}