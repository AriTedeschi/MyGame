import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_game/core/themes/app_colors.dart';
import 'package:my_game/core/themes/app_text_styles.dart';
import 'package:my_game/domain/entity/game.dart';
import 'package:my_game/domain/entity/post.dart';
import 'package:my_game/domain/entity/user.dart';
import 'package:my_game/presentation/bloc/post_bloc.dart';
import 'package:my_game/presentation/widgets/post_card.dart';
import 'package:my_game/presentation/widgets/post_input.dart';

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

  _GamePageState() {
    getAllPosts();
  }

  getAllPosts() async {
    posts = await postBloc.findAll();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = widget.gamePageArguments.user;
    final game = widget.gamePageArguments.game;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.15),
        child: MyAppBar(user: user),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        color: AppColors.background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () => Navigator.pushReplacementNamed(
                      context,
                      '/home',
                      arguments: user,
                    ),
                    child:
                        const Icon(Icons.arrow_back, color: Colors.blueAccent),
                  ),
                  Text(
                    game.name,
                    textAlign: TextAlign.center,
                    style: TextStyles.titleBoldHeadingGame,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: TextButton(
                      onPressed: () => const PostInput(),//TODO: fazer o post
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
