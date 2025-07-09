import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // Headings from PRD (Poppins)
  static final TextStyle heading1 = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  ); //

  static final TextStyle heading2 = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  ); //

  // Body from PRD (Roboto)
  static final TextStyle bodyText = GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.text,
  ); //
  
  static final TextStyle bodyTextLight = bodyText.copyWith(color: AppColors.grey);

  // Buttons/Labels from PRD (Roboto)
  static final TextStyle buttonLabel = GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w500, // Medium weight
    color: AppColors.white,
  ); //
  
  static final TextStyle label = GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.lightGrey,
  );
}