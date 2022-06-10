import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_game/core/themes/app_colors.dart';
import 'package:my_game/core/themes/app_images.dart';
import 'package:my_game/domain/entity/user.dart';
import 'package:my_game/presentation/bloc/user_bloc.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    final userBloc = GetIt.I.get<UserBloc>();
    final size = MediaQuery.of(context).size;

    if (userBloc.isLoading()) {
      return loading(size);
    } else {
      authenticate(userBloc);
    }
    return const Scaffold();
  }

  authenticate(UserBloc userBloc) async {
    User? user = await userBloc.findUser();
    if (user == null) {
      Navigator.pushReplacementNamed(context, '/landing');
    } else {
      Navigator.pushReplacementNamed(context, '/home', arguments: user);
    }
  }

}

loading(Size size) {
  return Scaffold(
    backgroundColor: AppColors.primary,
    body: Stack(
      children: [
        Positioned(
          top: size.height * 0.1,
          left: size.width * 0.1,
          right: size.width * 0.1,
          bottom: size.height * 0.1,
          child: Image.asset(AppImages.logo),
        ),
        Positioned(
          top: size.height * 0.6,
          left: size.width * 0.45,
          right: size.width * 0.45,
          bottom: size.height * 0.35,
          child: const CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}
