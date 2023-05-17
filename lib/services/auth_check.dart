import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tela_login/homepage/login_page.dart';
import 'package:tela_login/homepage/tela_menu.dart';
import 'package:tela_login/services/auth_services.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);
    if (auth.isLoading) {
      return loading();
    } else if (auth.usuario == null) {
      return const LoginPage();
    } else {
      return const TelaMenu(title: 'Menu Principal');
    }
  }
}


loading() {
  return const Scaffold(
    body: Center(child: CircularProgressIndicator()),
  );
}
