import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../domain/entites/shipment_entity.dart';
import '../../domain/repositories/shipment_repository.dart';
import '../data_sources/ship_mock_datasource.dart';

class ShipmentRepositoryImpl implements ShipmentRepository {
  final ShipmentDataSource dataSource;

  ShipmentRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<ShipmentEntity>>> getShipments() async {
    try {
      final shipments = await dataSource.getShipments();
      // The dataSource returns ShipmentModel, which is already a ShipmentEntity
      // so we can return it directly.
      return Right(shipments);
    } catch (e) {
      // In a real app, you would check for specific exceptions
      // like SocketException for network errors, etc.
      return const Left(ServerFailure(message: 'Failed to fetch shipments.'));
    }
  }

  @override
  Future<Either<Failure, ShipmentEntity>> getShipmentDetails(String id) async {
    try {
      final shipmentDetails = await dataSource.getShipmentDetails(id);
      return Right(shipmentDetails);
    } catch (e) {
      return const Left(ServerFailure(message: 'Failed to fetch shipment details.'));
    }
  }
}