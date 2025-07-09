part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

/// Event triggered to load the shipment data for the dashboard.
class LoadDashboard extends DashboardEvent {}