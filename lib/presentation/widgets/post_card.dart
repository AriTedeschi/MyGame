import 'package:flutter/material.dart';
import 'package:my_game/core/themes/app_colors.dart';
import 'package:my_game/core/themes/app_text_styles.dart';
import 'package:my_game/domain/entity/post.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      height: 300,
      decoration: BoxDecoration(
        color: AppColors.input,
        borderRadius: BorderRadius.circular(20),
        border: const Border.fromBorderSide(
          BorderSide(color: AppColors.stroke),
        ),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 30,
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    post.title,
                    textAlign: TextAlign.center,
                    style: TextStyles.titleBoldHeading,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                height: 2,
                width: size.width - 10,
                color: AppColors.stroke,
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: 45, right: 10, left: 10),
            child: Text(
              post.description,
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
                "Postado por : " + post.username,
                style: TextStyles.postedBy,
              ),
            ),
          ),
          Positioned(
            bottom: -10,
            left: 0,
            child: TextButton(
              onPressed: () => {}, //TODO:
              child: Text(
                "Respostas (" + post.replies.length.toString() + ")",
                style: TextStyles.postedBy,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
