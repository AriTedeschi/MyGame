import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_game/core/error/failure.dart';
import 'package:my_game/core/themes/app_colors.dart';
import 'package:my_game/core/themes/app_text_styles.dart';
import 'package:my_game/domain/entity/game.dart';
import 'package:my_game/domain/entity/user.dart';
import 'package:my_game/presentation/bloc/post_bloc.dart';
import 'package:my_game/presentation/component/form_decoration.dart';
import 'package:my_game/presentation/pages/game_page.dart';
import 'package:my_game/presentation/widgets/my_app_bar.dart';

class PostPage extends StatefulWidget {
  final PostPageArguments postPageArguments;

  const PostPage({Key? key, required this.postPageArguments}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final postBloc = GetIt.I.get<PostBloc>();
  final formKey = GlobalKey<FormState>();
  final title = TextEditingController();
  final content = TextEditingController();

  savePost(Game game, User user) async {
    try {
      postBloc.save(game, user, title.text, content.text);

      Navigator.pushReplacementNamed(
        context,
        '/game',
        arguments: GamePageArguments(
          user: user,
          game: game,
        ),
      );

    } on DatabaseFailure catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message,
            textAlign: TextAlign.center,
          ),
          backgroundColor: AppColors.input,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = widget.postPageArguments.user;
    final game = widget.postPageArguments.game;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.10),
        child: MyAppBar(user: user),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          color: AppColors.background,
          child: Center(
            child: Stack(
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
                            onPressed: () =>
                                Navigator.pushReplacementNamed(context, '/game',
                                    arguments: GamePageArguments(
                                      user: user,
                                      game: game,
                                    )),
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
                      ],
                    ),
                  ),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height * 0.15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text("Nova Postagem",
                            style: TextStyles.titleBoldHeadingGame),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: TextFormField(
                          controller: title,
                          keyboardType: TextInputType.multiline,
                          cursorColor: AppColors.heading,
                          style: TextStyles.inputContent,
                          decoration: FormDecoration.decorationPost("Título"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Título não pode ser vazio";
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        child: TextFormField(
                          minLines: 1,
                          maxLines: 10,
                          maxLength: 500,
                          controller: content,
                          keyboardType: TextInputType.multiline,
                          cursorColor: AppColors.heading,
                          style: TextStyles.inputContent,
                          decoration:
                              FormDecoration.decorationPost("Insira seu Post"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Post não pode ser vazio";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.9,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blueAccent,
                            onPrimary: AppColors.heading,
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              savePost(game, user);
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              "Postar",
                              style: TextStyle(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PostPageArguments {
  final User user;
  final Game game;

  PostPageArguments({required this.user, required this.game});
}
