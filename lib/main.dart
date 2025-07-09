import 'package:flutter/material.dart';
import 'package:logistics_go/app/navigation/app_router.dart'; // Import the router
import 'package:logistics_go/app/theme/app_colors.dart';
import 'package:logistics_go/app/theme/app_text_styles.dart';

import 'app/di/shipment_di.dart' as di;


void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LogisticsGo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.primary,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          error: AppColors.error,
        ),
        textTheme: TextTheme(
          displayLarge: AppTextStyles.heading1,
          displayMedium: AppTextStyles.heading2,
          bodyLarge: AppTextStyles.bodyText,
          labelLarge: AppTextStyles.buttonLabel,
        ),
        useMaterial3: true,
      ),
      // Use the router
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: AppRouter.dashboardRoute,
    );
  }
}