import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:my_game/core/error/exceptions/auth_exception.dart';
import 'package:my_game/core/themes/app_colors.dart';
import 'package:my_game/core/themes/app_text_styles.dart';
import 'package:my_game/domain/entity/user.dart';
import 'package:my_game/presentation/bloc/register_bloc.dart';
import 'package:my_game/presentation/component/form_decoration.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final registerBloc = GetIt.I.get<RegisterBloc>();
  final formKey = GlobalKey<FormState>();

  late String firstName;
  late String lastName;
  final email = TextEditingController();
  final emailValidate = TextEditingController();
  final password = TextEditingController();
  final passwordValidate = TextEditingController();

  bool loading = false;

  register() async {
    setState(() => loading = true);
    try {
      final user = User(
          firstName: firstName,
          lastName: lastName,
          email: email.text,
          username: '');
      await registerBloc.register(user, password.text);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)!.accountCreated,
            textAlign: TextAlign.center,
          ),
          backgroundColor: AppColors.input,
        ),
      );

      Navigator.pushReplacementNamed(context, '/login');
    } on AuthException catch (e) {
      //TODO:
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
                        padding: const EdgeInsets.only(bottom: 20),
                        child:
                            Text("Crie sua conta", style: TextStyles.titleLogin)),
                    //TODO: melhorar
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 24.0,
                      ),
                      child: TextFormField(
                        cursorColor: AppColors.heading,
                        decoration: FormDecoration.decoration('Nome'),
                        style: const TextStyle(color: AppColors.heading),
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            firstName = value;
                            return null;
                          }
                          return 'Insira seu nome';
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 24.0,
                      ),
                      child: TextFormField(
                        cursorColor: AppColors.heading,
                        decoration: FormDecoration.decoration("Sobrenome"),
                        style: const TextStyle(color: AppColors.heading),
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            lastName = value;
                            return null;
                          }
                          return 'Insira seu sobrenome'; //TODO: adicionar localização
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 24.0,
                      ),
                      child: TextFormField(
                        cursorColor: AppColors.heading,
                        controller: email,
                        decoration: FormDecoration.decoration('Email'),
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(color: AppColors.heading),
                        validator: (value) {
                          if (!EmailValidator.validate(value!)) {
                            return AppLocalizations.of(context)!.validEmail;
                          } else if (email.text != emailValidate.text) {
                            return AppLocalizations.of(context)!.validEqualEmail;
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 24.0,
                      ),
                      child: TextFormField(
                        cursorColor: AppColors.heading,
                        controller: emailValidate,
                        decoration:
                            FormDecoration.decoration('Confirme seu email'),
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(color: AppColors.heading),
                        validator: (value) {
                          if (email.text != emailValidate.text) {
                            return AppLocalizations.of(context)!.validEqualEmail;
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 24.0,
                      ),
                      child: TextFormField(
                        cursorColor: AppColors.heading,
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
                          } else if (password.text != passwordValidate.text) {
                            return 'Senhas não coincidem'; //TODO: adicionar localização
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 24.0,
                      ),
                      child: TextFormField(
                        cursorColor: AppColors.heading,
                        controller: passwordValidate,
                        obscureText: true,
                        decoration:
                            FormDecoration.decoration("Confirme sua senha"),
                        style: const TextStyle(color: AppColors.heading),
                        validator: (value) {
                          if (password.text != passwordValidate.text) {
                            return 'Senhas não coincidem'; //TODO: adicionar localização
                          }
                          return null;
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
                            register();
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
                                      "Register",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ],
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, '/login'),
                      child: const Text(
                        "Já possui cadastro? Logue-se",
                        style: TextStyle(color: Colors.white),
                      ), //TODO: Adicionar localização
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
