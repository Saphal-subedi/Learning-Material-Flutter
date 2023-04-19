import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Map<String, dynamic> data = {};
List<dynamic> user = [];

class rawapi extends StatefulWidget {
  const rawapi({super.key});

  @override
  State<rawapi> createState() => _rawapiState();
}

class _rawapiState extends State<rawapi> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Rest api"),
          centerTitle: true,
        ),
        body: ListView.separated(
            itemBuilder: ((context, index) {
              return ListTile(
                title: Text('${user[index]['title']}'),
              );
            }),
            separatorBuilder: ((context, index) {
              return Divider();
            }),
            itemCount: user.length),
        floatingActionButton: FloatingActionButton(
            child: Text("Press here to get news"),
            onPressed: (() {
              setState(() {
                feetchdata();
                user = data['articles'];
                print(user);
              });
            })),
      ),
    );
  }
}

void feetchdata() async {
  const url =
      "https://newsapi.org/v2/everything?q=tesla&from=2023-03-13&sortBy=publishedAt&apiKey=b0937910f52f4db6946c4b61e3a07136";
  final uri = Uri.parse(url);
  final response = await http.get(uri);
  final body = response.body;
  data = jsonDecode(body);
}
