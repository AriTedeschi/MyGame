import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:my_game/core/themes/app_colors.dart';
import 'package:my_game/core/themes/app_images.dart';
import 'package:my_game/domain/entity/user.dart';
import 'package:my_game/presentation/bloc/user_bloc.dart';
import 'package:my_game/presentation/component/form_decoration.dart';

class UsernamePage extends StatefulWidget {
  const UsernamePage({Key? key}) : super(key: key);

  @override
  State<UsernamePage> createState() => _UsernamePageState();
}

class _UsernamePageState extends State<UsernamePage> {
  final userBloc = GetIt.I.get<UserBloc>();
  final formKey = GlobalKey<FormState>();
  final username = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        color: AppColors.primary,
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Positioned(
            bottom: size.height * 0.05,
            left: size.width * 0.05,
            right: size.width * 0.05,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.10,
                ),
                Image.asset(AppImages.userIcon),
                SizedBox(
                  height: size.height * 0.10,
                ),
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: TextFormField(
                      cursorColor: AppColors.heading,
                      controller: username,
                      decoration: FormDecoration.decoration(
                        AppLocalizations.of(context)!.username,
                      ),
                      style: const TextStyle(color: AppColors.heading),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppLocalizations.of(context)!.validUsername;
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.10,
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blueAccent,
                      onPrimary: AppColors.heading,
                    ),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        User user =
                            await userBloc.updateUsername(username.text);
                        Navigator.pushReplacementNamed(
                          context,
                          '/home',
                          arguments: user,
                        );
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.check),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            AppLocalizations.of(context)!.cont,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
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
