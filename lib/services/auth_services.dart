
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class authException implements Exception {
  String message;
  authException(this.message);
}

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? usuario;
  bool isLoading = true;

  AuthService() {
    _authCheck();
  }

  void _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  _getUser() {
    usuario = _auth.currentUser;
    notifyListeners();
  }

  registar(String email, String senha) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw authException("Senha muito fraca");
      } else if (e.code == 'email-already-in-use') {
        throw authException("Email já cadastrado");
      }
    }
  }

  login(String email, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw authException('Email não cadastrado. Cadastre-se.');
      } else if (e.code == 'wrong-password') {
        throw authException("Senha incorreta. Tente novamente.");
      }
    }
  }

  logout() async {
    await _auth.signOut();
    _getUser();
  }
}
