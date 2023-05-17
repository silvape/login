import 'package:flutter/material.dart';
import 'package:tela_login/componts/user_tile.dart';
import 'package:tela_login/provider/users.dart';
import 'package:tela_login/routes/app_routes.dart';
import 'package:provider/provider.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  void initState() {
    super.initState();
    Provider.of<UsersProvider>(context, listen: false).loadContatos();
  }

  @override
  Widget build(BuildContext context) {
    final UsersProvider users = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.USER_FORM,
                );
              },
              icon: const Icon(Icons.add)),
        ],
        title: const Text(
          'Lista Contatos',
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: ListView.builder(
        itemCount: users.count,
        itemBuilder: (context, i) => UserTile(
          users.byIndex(i),
        ),
      ),
    );
  }
}
