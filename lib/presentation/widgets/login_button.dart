import 'package:flutter/material.dart';
import 'package:my_game/core/themes/app_colors.dart';
import 'package:my_game/core/themes/app_text_styles.dart';

class LoginButton extends StatelessWidget {
  final String title;
  final dynamic image;

  const LoginButton(this.title, this.image, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.shape,
        borderRadius: BorderRadius.circular(20),
        border:
            const Border.fromBorderSide(BorderSide(color: AppColors.stroke)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(image, width: 24, height: 25),
                const SizedBox(width: 10),
                Container(height: 50, width: 1, color: AppColors.stroke),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: TextStyles.buttonText),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
