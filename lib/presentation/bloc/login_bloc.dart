import 'dart:convert';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_game/core/error/exceptions/auth_exception.dart';
import 'package:my_game/core/error/failure.dart';
import 'package:my_game/data/model/user_model.dart';
import 'package:my_game/domain/usecases/get_user.dart';
import 'package:my_game/domain/usecases/save_user.dart';

import '../../core/auth/auth_controller.dart';

class LoginBloc {
  final AuthController authController;
  final GetUser getUser;
  final SaveUser saveUser;

  LoginBloc(
      {required this.getUser,
      required this.authController,
      required this.saveUser});

  signIn(String email, String password) async {
    authController.login(email, password);
  }

  googleSignIn() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        "email",
      ],
    );
    try {
      final response = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuthentication =
          await response!.authentication;
      final loggedUser =
          await authController.loginWithGoogle(googleAuthentication);

      final result = await getUser.execute(loggedUser!.uid);

      result.fold((failure) {}, (savedUser) async {
        print(savedUser);
        if (savedUser == null) {
          Map<String, dynamic>? map = parseJwt(googleAuthentication.idToken);
          final user = UserModel(
            uid: loggedUser.uid,
            firstName: map!["given_name"] ?? "",
            lastName: map["family_name"] ?? "",
            email: loggedUser.email!,
            username: "",
          );
          saveUser.userRepository.save(user);
        }
      });
    } on DatabaseFailure catch (e) {
      throw DatabaseFailure(e.message);
    } catch (error) {
      throw AuthException("Error authenticating on google");
    }
  }

  static Map<String, dynamic>? parseJwt(String? token) {
    if (token == null) return null;
    final List<String> parts = token.split('.');
    if (parts.length != 3) {
      return null;
    }

    final String payload = parts[1];
    final String normalized = base64Url.normalize(payload);
    final String resp = utf8.decode(base64Url.decode(normalized));

    final payloadMap = json.decode(resp);
    if (payloadMap is! Map<String, dynamic>) {
      return null;
    }
    return payloadMap;
  }
}
