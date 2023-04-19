import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class httpstate {
  final bool loading;
  final Map<String, dynamic> data;
  final String? errormsg;
  httpstate({this.loading = false, required this.data, this.errormsg});
}

class newservice {
  final url =
      "https://newsapi.org/v2/everything?q=tesla&from=2023-03-12&sortBy=publishedAt&apiKey=b0937910f52f4db6946c4b61e3a07136";
  Future<http.Response> getallnews() async {
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    return response;
  }
}

class saphal extends Cubit<httpstate> {
  saphal() : super(httpstate(data: {}));
  void getallnews() async {
    emit(httpstate(data: {}, loading: true));
    try {
      final res = await newservice().getallnews();

      final data = res.body;
      emit(httpstate(data: jsonDecode(data)));
    } catch (e) {
      print(" the error is provided $e");
      emit(httpstate(data: {}, errormsg: "Error is seen"));
    }
  }
}

class api extends StatelessWidget {
  const api({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => saphal()),
      ],
      child: MaterialApp(
        home: mainfile(),
      ),
    );
  }
}

class mainfile extends StatelessWidget {
  const mainfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<saphal, httpstate>(
        builder: (context, state) {
          return ListView.separated(
            shrinkWrap: true,
            itemBuilder: ((context, index) {
              final data = state.data;
              final article = data['articles'];
              return Container(
                width: 400,
                height: 100,
                child: ListTile(
                  leading: Text(article[index]),
                ),
              );
            }),
            separatorBuilder: ((context, index) => const Divider()),
            itemCount: 5,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<saphal>().getallnews();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
