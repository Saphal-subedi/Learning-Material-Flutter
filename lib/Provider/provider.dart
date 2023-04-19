import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class saphal with ChangeNotifier {
  var counter = 0;
  void increase() {
    counter = counter + 100;
    notifyListeners();
  }
}

class Providerexample extends StatelessWidget {
  const Providerexample({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => saphal(),
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text("I am practicing provider"),
          ),
          body: Consumer<saphal>(builder: (context, value, child) {
            return Text(
              '${value.counter}',
              style: TextStyle(
                fontSize: 20.0,
              ),
            );
          }),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              context.read<saphal>().increase();
              // Provider.of<saphal>(context, listen: false).increase();
            },
            label: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
