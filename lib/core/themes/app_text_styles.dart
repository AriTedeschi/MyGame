import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_game/core/themes/app_colors.dart';

class TextStyles {
  static final titleLogin = GoogleFonts.lexend(
    fontSize: 40,
    fontWeight: FontWeight.w600,
    color: AppColors.heading,
  );
  static final titleRegular = GoogleFonts.lexend(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppColors.heading,
  );
  static final titleBoldHeading = GoogleFonts.lexend(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.heading,
  );
  static final buttonText = GoogleFonts.lexend(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.input,
  );
}
