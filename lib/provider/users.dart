import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tela_login/data/dummy_users.dart';
import 'package:tela_login/models/user.dart';

class UsersProvider with ChangeNotifier {
  static const _baseUrl =
      'https://bamboo-diode-384619-default-rtdb.firebaseio.com/';

  final Map<String, User> _items = {...DUMMY_USERS};

  Future<List<User>> get all async {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  Future<void> loadContatos() async {
    final response = await http.get(Uri.parse("$_baseUrl/contatos.json"));
    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((contatoid, contatoData) {
      _items.putIfAbsent(
        contatoid,
        () => User(
          name: contatoData['name'] ?? '',
          email: contatoData['email'] ?? '',
          fone: contatoData['fone'] ?? '',
          avatarUrl: contatoData['avatarUrl'] ?? '',
        ),
      );
    });
  }

  User byIndex(int i) {
    return _items.values.elementAt(i);
  }

  Future<void> put(User user) async {
    if (user == null) {
      return;
    }

    if (user.id != null &&
        user.id.trim().isNotEmpty &&
        _items.containsKey(user.id)) {
      await http.patch(
        Uri.parse("$_baseUrl/contatos/${user.id}.json"),
        body: json.encode({
          'name': user.name,
          'email': user.email,
          'fone': user.fone,
          'avatarUrl': user.avatarUrl,
        }),
      );

      _items.update(
        user.id,
        (_) => User(
          id: user.id,
          name: user.name,
          email: user.email,
          fone: user.fone,
          avatarUrl: user.avatarUrl,
        ),
      );
    } else {
      final response = await http.post(
        Uri.parse("$_baseUrl/contatos.json"),
        body: json.encode({
          'name': user.name,
          'email': user.email,
          'fone': user.fone,
          'avatarUrl': user.avatarUrl,
        }),
      );

      final id = json.decode(response.body)['name'] ?? '';
      print(jsonDecode(response.body));
      _items.putIfAbsent(
        id,
        () => User(
          id: id,
          name: user.name,
          email: user.email,
          fone: user.fone,
          avatarUrl: user.avatarUrl,
        ),
      );
    }
    notifyListeners();
  }

  Future<void> remove(User? user) async {
    if (user != null && user.id != null) {
      await http.delete(Uri.parse("$_baseUrl/contatos/${user.id}.json"));
      _items.remove(user.id);
      notifyListeners();
    }
  }
}
