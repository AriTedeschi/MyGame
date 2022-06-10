import 'package:flutter/material.dart';
import 'package:my_game/core/themes/app_colors.dart';
import 'package:my_game/core/themes/app_text_styles.dart';
import 'package:my_game/domain/entity/game.dart';
import 'package:my_game/domain/entity/post.dart';
import 'package:my_game/domain/entity/user.dart';
import 'package:my_game/presentation/pages/game_page.dart';
import 'package:my_game/presentation/widgets/my_app_bar.dart';
import 'package:my_game/presentation/widgets/reply_card.dart';

import 'new_reply_page.dart';

class PostPage extends StatefulWidget {
  final PostPageArguments postPageArguments;

  const PostPage({Key? key, required this.postPageArguments}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {

  _PostPageState() {
    refresh();
  }
  refresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final post = widget.postPageArguments.post;
    final user = widget.postPageArguments.user;
    final game = widget.postPageArguments.game;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.10),
        child: MyAppBar(user: user),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        color: AppColors.background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 2,
                      child: TextButton(
                        onPressed: () => Navigator.pushReplacementNamed(
                          context,
                          '/game',
                          arguments: GamePageArguments(user: user, game: game),
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    Positioned(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Respostas",
                          textAlign: TextAlign.center,
                          style: TextStyles.titleBoldHeadingGame,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 2.5,
                      child: TextButton(
                        onPressed: () => Navigator.pushReplacementNamed(
                          context,
                          '/newReply',
                          arguments: NewReplyPageArguments(
                              post: post, user: user, game: game),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.green,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: post.replies.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return ReplyCard(
                      reply: post.replies[index], user: user, game: game);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PostPageArguments {
  final Post post;
  final User user;
  final Game game;

  PostPageArguments(
      {required this.post, required this.user, required this.game});
}
