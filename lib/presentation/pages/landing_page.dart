import 'package:flutter/material.dart';
import 'package:my_game/core/themes/app_colors.dart';
import 'package:my_game/core/themes/app_images.dart';
import 'package:my_game/core/themes/app_text_styles.dart';
import 'package:my_game/presentation/widgets/login_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
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
                  Image.asset(AppImages.logo),
                  SizedBox(
                    height: size.height * 0.15,
                  ),
                  Text(
                      "PA - PA038TIN1\n"
                      "Mobile - CP110TIN1\n\n"
                      "Ari Tedeschi Junior - 190075\n"
                      "Joel Ribeiro B. Junior - 190304\n"
                      "Matheus H. G. da Silva - 190038\n"
                      "Rafael R. Rodrigues - 190320\n"
                      "Vinicius A. Barbosa - 180326",
                      style: TextStyles.titleRegular,
                    ),
                  SizedBox(
                    height: size.height * 0.15,
                  ),
                  LoginButton(
                    AppLocalizations.of(context)!.loginEmail,
                    AppImages.emailIcon,
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/login'); //TODO: fazer login
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: LoginButton(
                      AppLocalizations.of(context)!.loginGoogle,
                      AppImages.googleIcon,
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/login'); //TODO: fazer login com google
                      },
                    ),
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
