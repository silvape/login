import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tela_login/provider/users.dart';

import '../models/user.dart';

class UserForm extends StatefulWidget {
  UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();
  bool _isLoading = false;
  final Map<String, String> _formData = {};

  void _loadForData(User user) {
    _formData['id'] = user.id;
    _formData['name'] = user.name;
    _formData['email'] = user.email;
    _formData['fone'] = user.fone;
    _formData['avatarUrl'] = user.avatarUrl;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    try {
      final User user = ModalRoute.of(context)?.settings.arguments as User;

      _loadForData(user);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Formulário Contato'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () async {
              final isValid = _form.currentState?.validate();

              if (isValid!) {
                _form.currentState?.save();

                setState(() {
                  _isLoading = true;
                });

                await Provider.of<UsersProvider>(context, listen: false).put(
                  User(
                    id: _formData['id'].toString(),
                    name: _formData['name'].toString(),
                    email: _formData['email'].toString(),
                    fone: _formData['fone'].toString(),
                    avatarUrl: _formData['avatarUrl'].toString(),
                  ),
                );

                setState(() {
                  _isLoading = false;
                });

                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                  key: _form,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        initialValue: _formData['name'],
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(labelText: 'Nome'),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Nome Inválido!!";
                          }

                          if (value.trim().length < 3) {
                            return 'Nome Mínimo 3 letras';
                          }
                          return null;
                        },
                        onSaved: (value) => _formData['name'] = value!,
                      ),
                      TextFormField(
                        initialValue: _formData['email'],
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(labelText: 'Email'),
                        onSaved: (value) => _formData['email'] = value!,
                      ),
                      TextFormField(
                        initialValue: _formData['fone'],
                        keyboardType: TextInputType.number,
                        decoration:
                            const InputDecoration(labelText: 'Telefone'),
                        onSaved: (value) => _formData['fone'] = value!,
                      ),
                      TextFormField(
                        initialValue: _formData['avatarUrl'],
                        decoration:
                            const InputDecoration(labelText: 'Url do Avatar'),
                        onSaved: (value) => _formData['avatarUrl'] = value!,
                      )
                    ],
                  )),
            ),
    );
  }
}
