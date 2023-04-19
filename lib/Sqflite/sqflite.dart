import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   TodoService().connectDb();
//   runApp(const MyApp());
// }

class MyAppp extends StatelessWidget {
  const MyAppp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => checkBoxCubit())],
      child: MaterialApp(
        home: TodoApp(),
      ),
    );
  }
}

class TodoApp extends StatelessWidget {
  TodoApp({super.key});

  final TextEditingController stringController = TextEditingController();

  @override
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
                    icon: const Icon(Icons.delete),
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
              separatorBuilder: (context, index) => const Divider(),
              itemCount: state.length),
          floatingActionButton: FloatingActionButton(
            onPressed: (() {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Column(
                        children: [
                          const SizedBox(height: 30),
                          TextFormField(
                            controller: stringController,
                            decoration: InputDecoration(
                              hintText: "Enter your value",
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            color: Colors.red,
                            child: IconButton(
                              onPressed: (() {
                                TodoService().insert(
                                    Saphall(title: stringController.text));
                                TodoService().readSaphal();
                                context
                                    .read<checkBoxCubit>()
                                    .add(text: stringController.text);
                                Navigator.pop(context);
                              }),
                              icon: const Icon(Icons.add),
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    );
                  });
            }),
            child: const Icon(Icons.add),
          ),
        );
      }),
    );
  }
}

class Saphall {
  int? id;
  bool value;
  String title;

  Saphall({this.id, required this.title, this.value = false});

  Saphall copyWith({bool? value, String? title}) {
    return Saphall(title: title ?? this.title, value: value ?? this.value);
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
    };
  }
}

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

//step 1 class banauney
class TodoService {
  //step 2 connect garnu parxa database
  Future<Database> connectDb() async {
    var database = await openDatabase(
        join(await getDatabasesPath(), 'todoDb.db'),
        version: 1, onCreate: (db, version) {
      db.query(
        'CREATE TABLE todoTable(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT',
//pahela run garauda db.query garaune ra ekchoti create vaisakepaxi db.execute garaune
      );
    }, onConfigure: onConfigure);
    if (database != null) {
      print('Database connected successfully ');
      return database;
    } else {
      print('Unable to connect to database ');
      return database;
    }
  }

  onConfigure(Database db) async {
    await db.execute("PRAGMA foreign_keys = ON");
  }

  insert(Saphall saphal) async {
    final db = await TodoService().connectDb();
    db.insert(
      'todoTable',
      saphal.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Saphall>> readSaphal() async {
    final db = await TodoService().connectDb();
    final dbRead = await db.query('todoTable');
    return List.generate(
      dbRead.length,
      (index) => Saphall(
        title: dbRead[index]['title'] as String,
        id: dbRead[index]['id'] as int,
      ),
    );
  }

  delete(int id) async {
    final db = await TodoService().connectDb();
    db.delete(
      'todoTable',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
