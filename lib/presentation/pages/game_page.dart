import 'package:flutter/material.dart';
import 'package:my_game/core/themes/app_colors.dart';
import 'package:my_game/domain/entity/game.dart';
import 'package:my_game/domain/entity/user.dart';

class GamePage extends StatefulWidget {
  final GamePageArguments gamePageArguments;

  const GamePage({Key? key, required this.gamePageArguments}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
    );
  }
}

class GamePageArguments {
  final User user;
  final Game game;

  GamePageArguments({required this.user, required this.game});
}
