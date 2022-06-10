import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:my_game/core/error/exceptions/auth_exception.dart';
import 'package:my_game/core/themes/app_colors.dart';
import 'package:my_game/core/themes/app_text_styles.dart';
import 'package:my_game/domain/entity/user.dart';
import 'package:my_game/presentation/bloc/user_bloc.dart';
import 'package:my_game/presentation/component/form_decoration.dart';

class ProfilePage extends StatefulWidget {
  final User user;

  const ProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final userBloc = GetIt.I.get<UserBloc>();
  final formKey = GlobalKey<FormState>();

  late String firstName;
  late String lastName;
  late String username;

  bool loading = false;

  updateUser(User user) async {
    setState(() => loading = true);
    try {
      User userUpdated = User(
        firstName: firstName,
        lastName: lastName,
        username: username,
        email: user.email,
      );
      userBloc.updateUser(userUpdated);

      Navigator.pushReplacementNamed(context, '/home', arguments: userUpdated);
    } on AuthException catch (e) {
      setState(() => loading = false);
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
    final user = widget.user;

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Container(
        color: AppColors.primary,
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(
                height: size.height * 0.17,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: () => Navigator.pushReplacementNamed(
                              context,
                              '/home',
                              arguments: user,
                            ),
                            child: const Icon(
                              Icons.home,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Meu Perfil",
                          textAlign: TextAlign.center,
                          style: TextStyles.titleBoldHeadingGame,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              userBloc.logout();
                              Navigator.pushReplacementNamed(
                                  context, '/landing');
                            },
                            child: const Icon(
                              Icons.logout,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height * 0.06,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 24.0,
                        ),
                        child: TextFormField(
                          initialValue: user.firstName,
                          cursorColor: AppColors.heading,
                          decoration: FormDecoration.decoration(
                              AppLocalizations.of(context)!.firstName),
                          style: const TextStyle(color: AppColors.heading),
                          validator: (value) {
                            if (value!.isNotEmpty) {
                              firstName = value;
                              return null;
                            }
                            return AppLocalizations.of(context)!.validFirstName;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 24.0,
                        ),
                        child: TextFormField(
                          initialValue: user.lastName,
                          cursorColor: AppColors.heading,
                          decoration: FormDecoration.decoration(
                              AppLocalizations.of(context)!.lastName),
                          style: const TextStyle(color: AppColors.heading),
                          validator: (value) {
                            if (value!.isNotEmpty) {
                              lastName = value;
                              return null;
                            }
                            return AppLocalizations.of(context)!.validLastName;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 24.0,
                        ),
                        child: TextFormField(
                          initialValue: user.username,
                          cursorColor: AppColors.heading,
                          decoration: FormDecoration.decoration(
                              AppLocalizations.of(context)!.username),
                          style: const TextStyle(color: AppColors.heading),
                          validator: (value) {
                            if (value!.isNotEmpty) {
                              username = value;
                              return null;
                            }
                            return AppLocalizations.of(context)!.username;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 24.0,
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blueAccent,
                            onPrimary: AppColors.heading,
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              updateUser(user);
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: loading
                                ? [
                                    const Padding(
                                      padding: EdgeInsets.all(16),
                                      child: SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ]
                                : [
                                    const Icon(Icons.update),
                                    const Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Text(
                                        "Atualizar dados",
                                        style: TextStyle(fontSize: 20),
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
            ],
          ),
        ),
      ),
    );
  }
}
