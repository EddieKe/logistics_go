import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../entites/shipment_entity.dart';
import '../repositories/shipment_repository.dart';

class GetShipments {
  final ShipmentRepository repository;

  GetShipments(this.repository);

  // The 'call' method allows us to call the class instance as a function
  Future<Either<Failure, List<ShipmentEntity>>> call() async {
    return await repository.getShipments();
  }
}