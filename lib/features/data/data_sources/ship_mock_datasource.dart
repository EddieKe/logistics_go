import '../models/shipment_model.dart';

// Abstract class defining the contract for our data source
abstract class ShipmentDataSource {
  Future<List<ShipmentModel>> getShipments();
  Future<ShipmentModel> getShipmentDetails(String id);
}

// Implementation of the data source that returns mock data
class ShipmentMockDataSourceImpl implements ShipmentDataSource {
  // A hardcoded list of shipments
  static final List<ShipmentModel> _mockShipments = [
    ShipmentModel(
      id: 'SHP-001',
      status: 'In Transit',
      estimatedTimeOfArrival: DateTime.now().add(const Duration(days: 2)),
      origin: 'Nairobi, Kenya',
      destination: 'Dubai, United Arab Emirates',
      progress: [
        ShipmentProgressModel(
          location: 'Dubai, United Arab Emirates',
          description: 'Arrived at destination port',
          timestamp: DateTime.now().subtract(const Duration(hours: 6)),
        ),
        ShipmentProgressModel(
          location: 'In Transit - Indian Ocean',
          description: 'Departed from origin port',
          timestamp: DateTime.now().subtract(const Duration(days: 4)),
        ),
        ShipmentProgressModel(
          location: 'Nairobi, Kenya',
          description: 'Shipment picked up',
          timestamp: DateTime.now().subtract(const Duration(days: 5)),
        ),
      ],
    ),
    ShipmentModel(
      id: 'SHP-002',
      status: 'Delivered',
      estimatedTimeOfArrival: DateTime.now().subtract(const Duration(days: 1)),
      origin: 'Dubai, United Arab Emirates',
      destination:  'Shanghai, China',
       progress: [
         ShipmentProgressModel(
          location:  'Shanghai, China',
          description: 'Delivered to recipient',
          timestamp: DateTime.now().subtract(const Duration(days: 1)),
        ),
        ShipmentProgressModel(
          location: 'Rotterdam, Netherlands',
          description: 'Out for delivery',
          timestamp: DateTime.now().subtract(const Duration(days: 2)),
        ),
      ],
    ),
     ShipmentModel(
      id: 'SHP-003',
      status: 'Issue',
      estimatedTimeOfArrival: DateTime.now().add(const Duration(days: 1)),
      origin: 'London, UK',
      destination: 'Nairobi, Kenya',
      progress: [
        ShipmentProgressModel(
          location: 'Customs - JKIA, Nairobi',
          description: 'Shipment held at customs',
          timestamp: DateTime.now().subtract(const Duration(hours: 12)),
        ),
         ShipmentProgressModel(
          location: 'London, UK',
          description: 'Shipment picked up',
          timestamp: DateTime.now().subtract(const Duration(days: 3)),
        ),
      ],
    ),
  ];

  @override
  Future<List<ShipmentModel>> getShipments() async {
    // Simulate a network delay
    await Future.delayed(const Duration(milliseconds: 800));
    return _mockShipments;
  }

  @override
  Future<ShipmentModel> getShipmentDetails(String id) async {
    // Simulate a network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockShipments.firstWhere((shipment) => shipment.id == id,
        orElse: () => throw Exception('Shipment not found!'));
  }
}