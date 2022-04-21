import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_game/core/themes/app_colors.dart';

class TextStyles {
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
  static final buttonText = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.input,
  );
}