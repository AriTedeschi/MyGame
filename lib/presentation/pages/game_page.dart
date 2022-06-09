import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_game/core/themes/app_colors.dart';
import 'package:my_game/core/themes/app_text_styles.dart';
import 'package:my_game/domain/entity/game.dart';
import 'package:my_game/domain/entity/post.dart';
import 'package:my_game/domain/entity/user.dart';
import 'package:my_game/presentation/bloc/post_bloc.dart';
import 'package:my_game/presentation/pages/post_page.dart';
import 'package:my_game/presentation/widgets/post_card.dart';

import '../widgets/my_app_bar.dart';

class GamePage extends StatefulWidget {
  final GamePageArguments gamePageArguments;

  const GamePage({Key? key, required this.gamePageArguments}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final postBloc = GetIt.I.get<PostBloc>();
  List<Post> posts = <Post>[];

  getPosts(String name) async {
    posts = await postBloc.findByGame(name);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = widget.gamePageArguments.user;
    final game = widget.gamePageArguments.game;

    getPosts(game.name);

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
                          '/home',
                          arguments: user,
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
                          game.name,
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
                          '/newPost',
                          arguments: PostPageArguments(
                            user: user,
                            game: game,
                          )
                        ), //TODO: fazer o post
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
                itemCount: posts.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return PostCard(post: posts[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GamePageArguments {
  final User user;
  final Game game;

  GamePageArguments({required this.user, required this.game});
}
