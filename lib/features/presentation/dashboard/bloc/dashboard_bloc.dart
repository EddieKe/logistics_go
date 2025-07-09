
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entites/shipment_entity.dart';
import '../../../domain/use_cases/get_shipments.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetShipments getShipments;

  DashboardBloc({required this.getShipments}) : super(DashboardInitial()) {
    on<LoadDashboard>(_onLoadDashboard);
  }

  Future<void> _onLoadDashboard(
    LoadDashboard event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardLoading());
    final failureOrShipments = await getShipments();

    failureOrShipments.fold(
      (failure) => emit(DashboardError(message: failure.message)),
      (shipments) => emit(DashboardLoaded(shipments: shipments)),
    );
  }
}