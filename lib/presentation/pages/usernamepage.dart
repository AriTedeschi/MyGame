import 'package:flutter/material.dart';
import 'package:my_game/core/themes/app_colors.dart';
import 'package:my_game/core/themes/app_images.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_game/presentation/widgets/username_button.dart';

class UsernamePage extends StatefulWidget {
  const UsernamePage({Key? key}) : super(key: key);

  @override
  State<UsernamePage> createState() => _UsernamePageState();
}

class _UsernamePageState extends State<UsernamePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        color: AppColors.primary,
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Positioned(
              bottom: size.height * 0.05,
              left: size.width * 0.1,
              right: size.width * 0.1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.10,
                  ),
                  Image.asset(AppImages.userIcon),
                  SizedBox(
                    height: size.height * 0.15,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter a username',
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.15,
                  ),
                  UsernameButton(

                    AppLocalizations.of(context)!.cont,
                    AppImages.continueIcon,
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/landing'); //
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
