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
      await registerBloc.register(user, password.text, context);

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
                      child: Text(
                          AppLocalizations.of(context)!.createYourAccount,
                          style: TextStyles.titleLogin),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 24.0,
                      ),
                      child: TextFormField(
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
                        cursorColor: AppColors.heading,
                        decoration: FormDecoration.decoration(
                            AppLocalizations.of(context)!.lastName),
                        style: const TextStyle(color: AppColors.heading),
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            lastName = value;
                            return null;
                          }
                          return AppLocalizations.of(context)!
                              .validLastName;
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
                            return AppLocalizations.of(context)!
                                .validEqualEmail;
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
                        decoration: FormDecoration.decoration(
                            AppLocalizations.of(context)!.confirmEmail),
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(color: AppColors.heading),
                        validator: (value) {
                          if (!EmailValidator.validate(value!)) {
                            return AppLocalizations.of(context)!.validEmail;
                          } else if (email.text != emailValidate.text) {
                            return AppLocalizations.of(context)!
                                .validEqualEmail;
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
                            return AppLocalizations.of(context)!
                                .validPasswordEmpty;
                          } else if (value.length < 8) {
                            return AppLocalizations.of(context)!
                                .validPasswordLength;
                          } else if (password.text != passwordValidate.text) {
                            return AppLocalizations.of(context)!
                                .validPasswordEqual;
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
                        decoration: FormDecoration.decoration(
                            AppLocalizations.of(context)!.confirmPassword),
                        style: const TextStyle(color: AppColors.heading),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!
                                .validPasswordEmpty;
                          } else if (value.length < 8) {
                            return AppLocalizations.of(context)!
                                .validPasswordLength;
                          } else if (password.text != passwordValidate.text) {
                            return AppLocalizations.of(context)!
                                .validPasswordEqual;
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
                                   Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      AppLocalizations.of(context)!.signUp,
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ],
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, '/login'),
                      child: Text(
                        AppLocalizations.of(context)!.changeToLoginPage,
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
