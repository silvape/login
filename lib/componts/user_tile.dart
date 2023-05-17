import 'package:flutter/material.dart';
import 'package:tela_login/models/user.dart';
import 'package:tela_login/provider/users.dart';
import 'package:tela_login/routes/app_routes.dart';
import 'package:provider/provider.dart';

class UserTile extends StatelessWidget {
  final User user;

  const UserTile(this.user, {super.key});
  
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    final avatar = user.avatarUrl == null || user.avatarUrl.isEmpty
        ? const CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl));
    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.USER_FORM,
                    arguments: user,
                  );
                },
                color: Colors.orange,
                icon: const Icon(Icons.edit)),
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Deletar Contato.'),
                      content: const Text('Tem certeza?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Provider.of<UsersProvider>(context, listen: false)
                                .remove(user);
                            Navigator.of(context).pop();
                          },
                          child: const Text('Sim'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Não'),
                        ),
                      ],
                    ),
                  );
                },
                color: Colors.red,
                icon: const Icon(Icons.delete)),
          ],
        ),
      ),
    );
  }
}
