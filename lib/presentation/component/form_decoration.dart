import 'package:flutter/material.dart';
import 'package:my_game/core/themes/app_colors.dart';

class FormDecoration {
  static decoration(String field) {
    return InputDecoration(
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.heading),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.heading,
          width: 2.5,
        ),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.error,
          width: 2.5,
        ),
      ),
      labelText: field,
      errorStyle: const TextStyle(color: AppColors.error),
      labelStyle: const TextStyle(color: AppColors.heading),
      //floatingLabelStyle: const TextStyle(color: AppColors.error),//TODO: encontrar um jeito de mudar a cor
    );
  }
}
