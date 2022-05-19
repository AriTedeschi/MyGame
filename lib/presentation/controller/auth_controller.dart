import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../core/error/exceptions/auth_exception.dart';

class AuthController extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? loggedUser;
  bool isLoading = true;

  AuthController() {
    _authenticate();
  }

  _authenticate() {
    auth.authStateChanges().listen((User? user) {
      loggedUser = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  _setUser() {
    loggedUser = auth.currentUser;
    notifyListeners();
  }

  login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      _setUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException('Senha Fraca'); //TODO: ajustar mensagens de erro
      } else if (e.code == 'email-already-in-use') {
        throw AuthException("email em uso");
      }
    }
    return null;
  }

  Future<User?> loginWithGoogle(
      GoogleSignInAuthentication googleAuthentication) async {
    try {
      final authCredential = GoogleAuthProvider.credential(
        idToken: googleAuthentication.idToken,
        accessToken: googleAuthentication.accessToken,
      );
      final userCredential = await auth.signInWithCredential(authCredential);

      _setUser();
      return userCredential.user;
    } catch (e) {
      throw AuthException('Erro ao Logar com Google');
    }
  }
}
