import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tela_login/maps.dart';
import 'package:tela_login/routes/app_routes.dart';
import 'package:tela_login/services/auth_check.dart';
import 'package:tela_login/services/auth_services.dart';
import 'package:tela_login/views/user_form.dart';
import 'package:tela_login/views/user_list.dart';
import 'package:tela_login/provider/users.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => AuthService()),
        ChangeNotifierProvider(create: (ctx) => UsersProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PROJETO FINAL',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          AppRoutes.HOME: (_) => const AuthCheck(),
          AppRoutes.USER_FORM: (_) => UserForm(),
          AppRoutes.USERLIST: (_) => const UserList(),
          AppRoutes.MAPS: (_) => const MyMapa(title: 'Meu Mapa')
        },
      ),
    );
  }
}
