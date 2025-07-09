part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

/// The initial state of the dashboard.
class DashboardInitial extends DashboardState {}

/// State indicating that dashboard data is being loaded.
class DashboardLoading extends DashboardState {}

/// State indicating that shipment data has been successfully loaded.
class DashboardLoaded extends DashboardState {
  final List<ShipmentEntity> shipments;

  const DashboardLoaded({required this.shipments});

  @override
  List<Object> get props => [shipments];
}

/// State indicating that an error occurred while loading data.
class DashboardError extends DashboardState {
  final String message;

  const DashboardError({required this.message});

  @override
  List<Object> get props => [message];
}