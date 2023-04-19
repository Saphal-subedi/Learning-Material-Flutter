import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class mausam extends StatefulWidget {
  const mausam({super.key});

  @override
  State<mausam> createState() => _mausamState();
}

class _mausamState extends State<mausam> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Forecasting today details"),
        ),
      ),
    );
  }
}
