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

class NewPostPage extends StatefulWidget {
  final NewPostPageArguments newPostPageArguments;

  const NewPostPage({Key? key, required this.newPostPageArguments}) : super(key: key);

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
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
    final user = widget.newPostPageArguments.user;
    final game = widget.newPostPageArguments.game;

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
                          decoration: FormDecoration.decorationPost("T??tulo"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "T??tulo n??o pode ser vazio";
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
                              return "Post n??o pode ser vazio";
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

class NewPostPageArguments {
  final User user;
  final Game game;

  NewPostPageArguments({required this.user, required this.game});
}
