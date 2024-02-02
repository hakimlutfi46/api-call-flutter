import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> users = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Rest API Call Contact',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            final title = user['name']['title'];
            final firstName = user['name']['first'];
            final lastName = user['name']['last'];

            final fullName = "$title $firstName $lastName";
            final phone = user['phone'];
            final imageProfile = user['picture']['thumbnail'];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(imageProfile),
              ),
              title: Text(fullName),
              subtitle: Text(phone),
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: fetchUsers,
        child: const Icon(
          Icons.replay_rounded,
          color: Colors.white,
        ),
      ),
    );
  }

  void fetchUsers() async {
    print('Fetch User Called');
    const url = 'https://randomuser.me/api/?results=25';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);

    setState(() {
      users = json['results'];
    });
    print('Fetch User Complete');
  }
}
