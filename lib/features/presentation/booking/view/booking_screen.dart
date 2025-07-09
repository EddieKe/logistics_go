import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_sizes.dart';
import '../../../../app/theme/app_text_styles.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pickupController = TextEditingController();
  final _destinationController = TextEditingController();
  final _packageDetailsController = TextEditingController();

  @override
  void dispose() {
    _pickupController.dispose();
    _destinationController.dispose();
    _packageDetailsController.dispose();
    super.dispose();
  }

  void _submitBooking() {
    // Validate the form
    if (_formKey.currentState!.validate()) {
      // If valid, show the success dialog
      _showSuccessDialog();
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success!', style: AppTextStyles.heading2),
          content: Text('Your shipment has been booked successfully.', style: AppTextStyles.bodyText),
          actions: <Widget>[
            TextButton(
              child: Text('OK', style: AppTextStyles.bodyText.copyWith(color: AppColors.primary)),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(); // Go back to the dashboard
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book a New Shipment', style: AppTextStyles.heading2.copyWith(color: AppColors.white)),
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: AppColors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.p16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Addresses', style: AppTextStyles.heading2),
              const SizedBox(height: AppSizes.p16),
              _buildTextFormField(
                controller: _pickupController,
                labelText: 'Pickup Address',
                icon: Icons.my_location,
              ),
              const SizedBox(height: AppSizes.p16),
              _buildTextFormField(
                controller: _destinationController,
                labelText: 'Destination Address',
                icon: Icons.location_on,
              ),
              const SizedBox(height: AppSizes.p32),
              Text('Package Details', style: AppTextStyles.heading2),
              const SizedBox(height: AppSizes.p16),
              _buildTextFormField(
                controller: _packageDetailsController,
                labelText: 'e.g., 1 box, 5kg, fragile electronics',
                icon: Icons.inventory_2,
                maxLines: 3,
              ),
              const SizedBox(height: AppSizes.p32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  padding: const EdgeInsets.symmetric(vertical: AppSizes.p16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.r12),
                  ),
                ),
                onPressed: _submitBooking,
                child: Text('Confirm Booking', style: AppTextStyles.buttonLabel),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    int? maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon, color: AppColors.primary),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppSizes.r12)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field cannot be empty';
        }
        return null;
      },
    );
  }
}