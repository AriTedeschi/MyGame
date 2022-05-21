import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../error/exceptions/auth_exception.dart';

class AuthController extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  bool isLoading = true;

  AuthController() {
    _authenticate();
  }

  _authenticate() {
    _auth.authStateChanges().listen((User? user) {
      this.user = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  _setUser() {
    user = _auth.currentUser;
    notifyListeners();
  }

  register(String email, String password, context) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _setUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException('Weak Password');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException(AppLocalizations.of(context)!.validUsedEmail);
      }
    }
    return null;
  }

  login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _setUser();
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message!); //TODO: ajustar erro
    }
    return null;
  }

  loginWithGoogle(GoogleSignInAuthentication googleAuthentication) async {
    try {
      final authCredential = GoogleAuthProvider.credential(
        idToken: googleAuthentication.idToken,
        accessToken: googleAuthentication.accessToken,
      );
      await _auth.signInWithCredential(authCredential);

      _setUser();
    } catch (e) {
      throw AuthException('Erro ao Logar com Google');
    }
  }

  logout() async {
    await _auth.signOut();
    _setUser();
  }
}
