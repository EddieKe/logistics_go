import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../entites/shipment_entity.dart';
import '../repositories/shipment_repository.dart';

class GetShipmentDetails {
  final ShipmentRepository repository;

  GetShipmentDetails(this.repository);

  Future<Either<Failure, ShipmentEntity>> call(String id) async {
    return await repository.getShipmentDetails(id);
  }
}