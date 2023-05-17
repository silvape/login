import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tela_login/routes/app_routes.dart';
import 'package:tela_login/services/auth_services.dart';

class TelaMenu extends StatefulWidget {
  const TelaMenu({super.key, required this.title});

  final String title;

  @override
  State<TelaMenu> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<TelaMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 150.0,
                  child: Image.asset("images/logo_ifpi.png"),
                ),
                const Divider(),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              AppRoutes.USERLIST,
                            );
                          },
                          child: const Text('Contatos')),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(AppRoutes.MAPS);
                          },
                          child: const Text('Localizar')),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                          onPressed: () => context.read<AuthService>().logout(),
                          child: const Text('Sair'))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
