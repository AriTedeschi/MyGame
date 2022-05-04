import 'package:flutter/material.dart';
import 'package:my_game/core/themes/app_colors.dart';
import 'package:my_game/core/themes/app_text_styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      color: AppColors.primary,
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          Positioned(
            top: size.height * 0.1,
            left: size.width * 0.1,
            right: size.width * 0.1,
            child: Text(
              "LOGIN PAGE",
              style: TextStyles.titleRegular,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
