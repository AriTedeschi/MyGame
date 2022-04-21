import 'package:flutter/material.dart';
import 'package:my_game/core/themes/app_colors.dart';
import 'package:my_game/presentation/pages/landing_page.dart';

void main() {
  runApp(const AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Game',
      initialRoute: '/',
      theme: ThemeData(
        primaryColor: AppColors.primary,
      ),
      routes: {
        '/': (context) => const LandingPage(),
      },
    );
  }
}
