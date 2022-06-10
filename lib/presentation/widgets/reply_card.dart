import 'package:flutter/material.dart';
import 'package:my_game/core/themes/app_colors.dart';
import 'package:my_game/core/themes/app_text_styles.dart';
import 'package:my_game/domain/entity/game.dart';
import 'package:my_game/domain/entity/reply.dart';
import 'package:my_game/domain/entity/user.dart';

class ReplyCard extends StatelessWidget {
  final Reply reply;
  final User user;
  final Game game;

  const ReplyCard(
      {Key? key, required this.reply, required this.user, required this.game})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      height: 200,
      decoration: BoxDecoration(
        color: AppColors.input,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 15, right: 10, left: 10),
            child: Text(
              reply.description,
              style: TextStyles.content,
            ),
          ),
          Positioned(
            bottom: 20,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              height: 2,
              width: size.width - 10,
              color: AppColors.stroke,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.only(right: 10, bottom: 5),
              child: Text(
                "Resposta de: " + reply.username,
                style: TextStyles.postedBy,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
