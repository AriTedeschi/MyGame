import 'package:flutter/material.dart';
import 'package:my_game/core/themes/app_colors.dart';
import 'package:my_game/core/themes/app_text_styles.dart';

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

  static decorationPost(String field) {
    return InputDecoration(
      hintText: field,
      hintStyle: TextStyles.inputContent,
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          color: AppColors.heading,
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          color: AppColors.heading,
        ),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.error),
      ),
    );
  }
}
