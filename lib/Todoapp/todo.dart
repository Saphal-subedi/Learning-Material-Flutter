import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

class todoapp extends StatefulWidget {
  todoapp({super.key});

  @override
  State<todoapp> createState() => _todoappState();
}

class _todoappState extends State<todoapp> {
  String? valuee;

  final stringcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("I am called");
    return Scaffold(
      body: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("${all[index].title}"),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    all.removeAt(index);
                  });
                },
              ),
              leading: Checkbox(
                value: all[index].value,
                onChanged: (val) {
                  print(val);
                  setState(() {
                    print(val);
                    all[index].value = val;
                  });
                },
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(),
          itemCount: all.length),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Column(
                    children: [
                      TextFormField(
                        onChanged: (value) {
                          valuee = "${value.toString()}";
                          print(valuee);
                        },
                        controller: stringcontroller,
                        decoration:
                            InputDecoration(hintText: "Enter your value"),
                      ),
                      SizedBox(height: 20),
                      Container(
                        color: Colors.red,
                        child: IconButton(
                          onPressed: (() {
                            setState(() {
                              all.add(
                                Saphall(title: "$valuee"),
                              );
                              Navigator.pop(context);
                            });
                          }),
                          icon: Icon(Icons.add),
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                );
              });
        }),
        child: Icon(Icons.add),
      ),
    );
  }
}

class Saphall {
  bool? value;
  final String title;
  Saphall({required this.title, this.value = false});
}

List<Saphall> all = [];

class update extends Cubit<Saphall> {
  update() : super(Saphall(title: ""));
  void add() {}

  void delete() {}
}
