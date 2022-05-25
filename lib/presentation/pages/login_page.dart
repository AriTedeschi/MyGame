import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:my_game/core/error/exceptions/auth_exception.dart';
import 'package:my_game/core/themes/app_colors.dart';
import 'package:my_game/core/themes/app_text_styles.dart';
import 'package:my_game/presentation/bloc/login_bloc.dart';
import 'package:my_game/presentation/component/form_decoration.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginBloc = GetIt.I.get<LoginBloc>();
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  bool loading = false;

  login() async {
    setState(() => loading = true);
    try {
      bool hasUsername = await loginBloc.signIn(email.text, password.text);
      if (!hasUsername) {
        Navigator.pushReplacementNamed(context, '/user');
      } else {
        Navigator.pushReplacementNamed(context, '/home');
      }
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

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Container(
        color: AppColors.primary,
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(AppLocalizations.of(context)!.welcome,
                            style: TextStyles.titleLogin)),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: TextFormField(
                        cursorColor: AppColors.heading,
                        controller: email,
                        decoration: FormDecoration.decoration('Email'),
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(color: AppColors.heading),
                        validator: (value) {
                          if (!EmailValidator.validate(value!)) {
                            return AppLocalizations.of(context)!.validEmail;
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 24.0,
                      ),
                      child: TextFormField(
                        controller: password,
                        obscureText: true,
                        decoration: FormDecoration.decoration(
                            AppLocalizations.of(context)!.password),
                        style: const TextStyle(color: AppColors.heading),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!
                                .validPasswordEmpty;
                          } else if (value.length < 8) {
                            return AppLocalizations.of(context)!
                                .validPasswordLength;
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueAccent,
                          onPrimary: AppColors.heading,
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            login();
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
                                  const Icon(Icons.check),
                                  const Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Text(
                                      "Login",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ],
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, '/register'),
                      child: Text(
                        AppLocalizations.of(context)!.changeToRegisterPage,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
