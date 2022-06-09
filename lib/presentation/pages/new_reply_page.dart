import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_game/core/error/failure.dart';
import 'package:my_game/core/themes/app_colors.dart';
import 'package:my_game/core/themes/app_text_styles.dart';
import 'package:my_game/domain/entity/game.dart';
import 'package:my_game/domain/entity/post.dart';
import 'package:my_game/domain/entity/user.dart';
import 'package:my_game/presentation/bloc/post_bloc.dart';
import 'package:my_game/presentation/component/form_decoration.dart';
import 'package:my_game/presentation/pages/post_page.dart';
import 'package:my_game/presentation/widgets/my_app_bar.dart';

class NewReplyPage extends StatefulWidget {
  final NewReplyPageArguments newReplyPageArguments;

  const NewReplyPage({Key? key, required this.newReplyPageArguments})
      : super(key: key);

  @override
  State<NewReplyPage> createState() => _NewReplyPageState();
}

class _NewReplyPageState extends State<NewReplyPage> {
  final postBloc = GetIt.I.get<PostBloc>();
  final formKey = GlobalKey<FormState>();
  final content = TextEditingController();

  savePost(Post post, User user, Game game) async {
    try {
      postBloc.addReply(post, user, content.text);

      Navigator.pushReplacementNamed(
        context,
        '/post',
        arguments: PostPageArguments(
          user: user,
          post: post,
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
    final user = widget.newReplyPageArguments.user;
    final post = widget.newReplyPageArguments.post;
    final game = widget.newReplyPageArguments.game;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.10),
        child: MyAppBar(user: user),
      ),
      body: Container(
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
                              Navigator.pushReplacementNamed(context, '/post',
                                  arguments: PostPageArguments(
                                    user: user,
                                    post: post,
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
                            "Nova Resposta",
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: TextFormField(
                        minLines: 1,
                        maxLines: 10,
                        maxLength: 250,
                        controller: content,
                        keyboardType: TextInputType.multiline,
                        cursorColor: AppColors.heading,
                        style: TextStyles.inputContent,
                        decoration: FormDecoration.decorationPost(
                            "Insira sua Resposta"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Resposta não pode ser vazia";
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
                            savePost(post, user, game);
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            "Salvar",
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
    );
  }
}

class NewReplyPageArguments {
  final User user;
  final Post post;
  final Game game;

  NewReplyPageArguments(
      {required this.user, required this.post, required this.game});
}
