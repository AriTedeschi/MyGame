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
      await loginBloc.signIn(email.text, password.text);
      Navigator.pushReplacementNamed(context, '/home');
    } on AuthException catch (e) {
      //TODO:
      setState(() => loading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Bem Vindo", style: TextStyles.titleLogin),
                  //TODO: melhorar
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
                          return 'Informa sua senha!'; //TODO: adicionar localização
                        } else if (value.length < 8) {
                          return 'Sua senha deve ter no mínimo 8 caracteres';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: ElevatedButton(
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
                    child: const Text("Não possuí cadastro? Registre-se"),//TODO: Adicionar localização
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
