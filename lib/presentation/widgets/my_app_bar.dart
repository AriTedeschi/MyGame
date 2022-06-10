import 'package:flutter/material.dart';
import 'package:my_game/core/themes/app_colors.dart';
import 'package:my_game/core/themes/app_images.dart';
import 'package:my_game/core/themes/app_text_styles.dart';
import 'package:my_game/domain/entity/user.dart';

class MyAppBar extends StatefulWidget {
  final User user;

  const MyAppBar({Key? key, required this.user}) : super(key: key);

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.15,
      width: size.width,
      color: AppColors.primary,
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.05,
          ),
          Center(
            child: ListTile(
              title: Text.rich(
                TextSpan(
                  text: "Olá, ",
                  style: TextStyles.titleRegular,
                  children: [
                    TextSpan(
                      text: widget.user.username,
                      style: TextStyles.titleBoldHeading,
                    ) //TODO: nacionalizar
                  ],
                ),
              ),
              trailing: TextButton(
                onPressed: () => Navigator.pushReplacementNamed(
                  context,
                  '/profile',
                  arguments: widget.user,
                ),
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: Image.asset(AppImages.userIcon),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
