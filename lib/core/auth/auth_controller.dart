import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../error/exceptions/auth_exception.dart';

class AuthController extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  bool isLoading = true;

  AuthController() {
    _authenticate();
  }

  _authenticate() {
    auth.authStateChanges().listen((User? user) {
      this.user = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  _setUser() {
    user = auth.currentUser;
    notifyListeners();
  }

  register(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _setUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException('Weak Password'); //TODO: ajustar mensagens de erro
      } else if (e.code == 'email-already-in-use') {
        throw AuthException("Email already in use");
      }
    }
    return null;
  }

  login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      _setUser();
    } on FirebaseAuthException catch (e) {
        throw AuthException(e.message!); //TODO: ajustar erro
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
