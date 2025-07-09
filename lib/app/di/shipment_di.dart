import 'package:get_it/get_it.dart';

import '../../features/data/data_sources/ship_mock_datasource.dart';
import '../../features/data/repositories/shipment_repository_impl.dart';
import '../../features/domain/repositories/shipment_repository.dart';
import '../../features/domain/use_cases/get_shipment_details.dart';
import '../../features/domain/use_cases/get_shipments.dart';
import '../../features/presentation/dashboard/bloc/dashboard_bloc.dart';
import '../../features/presentation/tracking/bloc/tracking_bloc.dart';

// Service Locator instance
final sl = GetIt.instance;

void init() {
  // BLoCs - We use a factory because we want a new instance of the BLoC each time.
  sl.registerFactory(() => DashboardBloc(getShipments: sl()));
  sl.registerFactory(() => TrackingBloc(getShipmentDetails: sl()));

  // Use Cases - Lazy singletons are fine here as they don't hold any state.
  sl.registerLazySingleton(() => GetShipments(sl()));
  sl.registerLazySingleton(() => GetShipmentDetails(sl()));

  // Repositories
  sl.registerLazySingleton<ShipmentRepository>(
    () => ShipmentRepositoryImpl(dataSource: sl()),
  );

  // Data Sources
  sl.registerLazySingleton<ShipmentDataSource>(
    () => ShipmentMockDataSourceImpl(),
  );
}