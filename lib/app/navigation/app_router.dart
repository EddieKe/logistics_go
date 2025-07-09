import 'package:flutter/material.dart';

import '../../features/presentation/booking/view/booking_screen.dart';
import '../../features/presentation/dashboard/view/dashboard_screen.dart';
import '../../features/presentation/tracking/view/tracking_screen.dart';

class AppRouter {
  static const String dashboardRoute = '/';
  static const String trackingRoute = '/tracking';
  static const String bookingRoute = '/booking'; 

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case dashboardRoute:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      
      
         case bookingRoute:
        return MaterialPageRoute(builder: (_) => const BookingScreen());  

        case trackingRoute:
        if (settings.arguments is String) {
          final shipmentId = settings.arguments as String;
          return MaterialPageRoute(
            builder: (_) => TrackingScreen(shipmentId: shipmentId),
          );
        }
        return _errorRoute();
  

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Page not found!')),
      ),
    );
  }
}