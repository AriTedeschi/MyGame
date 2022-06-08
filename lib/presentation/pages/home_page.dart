import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_game/core/themes/app_colors.dart';
import 'package:my_game/core/themes/app_text_styles.dart';
import 'package:my_game/domain/entity/game.dart';
import 'package:my_game/domain/entity/user.dart';
import 'package:my_game/presentation/bloc/game_bloc.dart';
import 'package:my_game/presentation/pages/game_page.dart';
import 'package:my_game/presentation/widgets/game_card.dart';
import 'package:my_game/presentation/widgets/my_app_bar.dart';

class HomePage extends StatefulWidget {
  final User user;

  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final gameBloc = GetIt.I.get<GameBloc>();
  List<Game> games = <Game>[];

  _HomePageState() {
    getAllGames();
  }

  getAllGames() async {
    games = await gameBloc.findAll();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.15),
        child: MyAppBar(user: widget.user),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        color: AppColors.background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 5),
              child: Text(
                'Escolha um Jogo:', //TODO: nacionalização
                textAlign: TextAlign.center,
                style: TextStyles.titleBoldHeadingGame,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: games.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return GameCard(
                    game: games[index],
                    onCardClick: () {
                      Navigator.pushReplacementNamed(
                        context,
                        '/game',
                        arguments: GamePageArguments(
                          user: widget.user,
                          game: games[index],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
