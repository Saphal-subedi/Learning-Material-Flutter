import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counterevent.dart';

class Saphal extends StatelessWidget {
  const Saphal({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => safal(),
        )
      ],
      child: MaterialApp(
        home: Scaffold(
          body: mainpage(),
        ),
      ),
    );
  }
}

class mainpage extends StatelessWidget {
  const mainpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          BlocBuilder<safal, int>(builder: (context, value) {
            return Text(
              "The number is $value",
              style: TextStyle(fontSize: 30),
            );
          }),
          SizedBox(height: 30),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  context.read<safal>().increment();
                },
                icon: Icon(Icons.add),
              ),
              SizedBox(width: 30),
              IconButton(
                onPressed: () {
                  context.read<safal>().decrement();
                },
                icon: Icon(Icons.remove),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
