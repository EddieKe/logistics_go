import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../entites/shipment_entity.dart';

abstract class ShipmentRepository {
  /// Gets a list of all shipments for the dashboard
  Future<Either<Failure, List<ShipmentEntity>>> getShipments();

  /// Gets the detailed information for a single shipment by its ID
  Future<Either<Failure, ShipmentEntity>> getShipmentDetails(String id);
}