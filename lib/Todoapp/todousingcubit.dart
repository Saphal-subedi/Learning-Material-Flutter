import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_flutter_class/Todoapp/todo.dart';

class todoappp extends StatelessWidget {
  todoappp({super.key});

  final TextEditingController stringcontroller = TextEditingController();

  @override
  //  MultiBlocProvider(
  //     providers: [
  //       //BlocProvider(create: (context) => update()),
  //       BlocProvider(create: (context) => checkBoxCubit())
  //     ],
  //     child: MaterialApp(
  Widget build(BuildContext context) {
    print("I am inside build context");
    return BlocBuilder<checkBoxCubit, List<Saphall>>(
        builder: ((context, state) {
      return Scaffold(
        body: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(state[index].title),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    context.read<checkBoxCubit>().delete(ok: index);
                  },
                ),
                leading: Checkbox(
                  value: state[index].value,
                  onChanged: (val) {
                    print(val);
                    context.read<checkBoxCubit>().updateCheckbox(
                        safal: state[index].copyWith(value: val), i: index);
                  },
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: state.length),
        floatingActionButton: FloatingActionButton(
          onPressed: (() {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Column(
                      children: [
                        SizedBox(height: 30),
                        TextFormField(
                          controller: stringcontroller,
                          decoration: InputDecoration(
                            hintText: "Enter your value",
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          color: Colors.red,
                          child: IconButton(
                            onPressed: (() {
                              context
                                  .read<checkBoxCubit>()
                                  .add(text: stringcontroller.text);
                              stringcontroller.clear();
                              Navigator.pop(context);
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
    }));
  }
}

class Saphall {
  bool value;
  String title;
  Saphall({required this.title, this.value = false});
  Saphall copyWith({bool? value, String? title}) {
    return Saphall(title: title ?? this.title, value: value ?? this.value);
  }
}

//List<Saphall> all = [];

// class update extends Cubit<Saphall> {
//   update() : super(Saphall(title: ""));
//   void add() {
//     emit(Saphall(title: "$text"));
//     all.add(Saphall(title: "$text"));
//   }

//   void delete({required int ok}) {
//     //emit(Saphall(title: "$text"));
//     all.removeAt(ok);
//   }

//   void change() {
//     emit(Saphall(title: "$text"));
//   }
// }

class checkBoxCubit extends Cubit<List<Saphall>> {
  checkBoxCubit() : super([]);
  void updateCheckbox({required Saphall safal, required int i}) {
    List<Saphall> alll = [...state];
    alll[i] = safal;
    emit(alll);
  }

  void delete({required int ok}) {
    List<Saphall> alll = [...state];
    alll.removeAt(ok);
    emit(alll);
  }

  void add({required String text}) {
    List<Saphall> alll = [...state];
    alll.add(Saphall(title: text));
    emit(alll);
  }
}
