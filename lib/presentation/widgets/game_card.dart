import 'package:flutter/material.dart';
import 'package:my_game/core/themes/app_text_styles.dart';
import 'package:my_game/domain/entity/game.dart';

class GameCard extends StatelessWidget {
  final Game game;
  final Function onCardClick;

  const GameCard({Key? key, required this.game, required this.onCardClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onCardClick();
      },
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          height: 180,
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(game.imageUrl, fit: BoxFit.cover),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(1),
                        Colors.transparent
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Text(game.name,
                          textAlign: TextAlign.center,
                          style: TextStyles.titleBoldHeading)
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
