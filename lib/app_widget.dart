import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_game/core/themes/app_colors.dart';
import 'package:my_game/presentation/pages/game_page.dart';
import 'package:my_game/presentation/pages/home_page.dart';
import 'package:my_game/presentation/pages/landing_page.dart';
import 'package:my_game/presentation/pages/login_page.dart';
import 'package:my_game/presentation/pages/profile_page.dart';
import 'package:my_game/presentation/pages/register_page.dart';
import 'package:my_game/presentation/pages/username_page.dart';
import 'package:my_game/presentation/widgets/auth_check.dart';

import 'domain/entity/user.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      title: 'My Game',
      home: const AuthCheck(),
      theme: ThemeData(
        primaryColor: AppColors.primary,
      ),
      routes: {
        '/landing': (context) => const LandingPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/user': (context) => const UsernamePage(),
        '/home': (context) => HomePage(
              user: ModalRoute.of(context)!.settings.arguments as User,
            ),
        '/game': (context) => GamePage(
            gamePageArguments: ModalRoute.of(context)!.settings.arguments
                as GamePageArguments),
        '/profile': (context) => ProfilePage(
              user: ModalRoute.of(context)!.settings.arguments as User,
            ),
      },
    );
  }
}
