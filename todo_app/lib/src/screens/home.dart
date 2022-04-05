import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Todo> todos = [
    // Todo(
    //   id: 1, details: 'Utang ni mamy',
    //   // title: 'Breakdown of debts'
    // ),
  ];
  final ScrollController _sc = ScrollController();
  final TextEditingController _tc = TextEditingController();
  final FocusNode _fn = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Todos App'),
      ),
      backgroundColor: Colors.blueAccent,
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Expanded(
                    child: Scrollbar(
                  controller: _sc,
                  child: SingleChildScrollView(
                    controller: _sc,
                    child: Column(
                      children: [
                        for (Todo todo in todos)
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: ListTile(
                                tileColor: Colors.white,
                                leading: Text(todo.id.toString()),
                                title: Text(todo.created.toString()),
                                subtitle: Text(todo.details),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        editTodo(todo.details, todo.id);
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        removeTodo(todo.id);
                                      },
                                    ),
                                  ],
                                )),
                          )
                      ],
                    ),
                  ),
                )),
                TextFormField(
                    controller: _tc,
                    focusNode: _fn,
                    maxLines: 5,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Enter description..",
                        focusedBorder: const OutlineInputBorder(),
                        enabledBorder: const OutlineInputBorder(),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        prefix: IconButton(
                          icon: const Icon(Icons.cancel, color: Colors.black),
                          onPressed: () {
                            _fn.unfocus();
                          },
                        ),
                        suffix: IconButton(
                            icon: const Icon(Icons.chevron_right_rounded,
                                color: Colors.black),
                            onPressed: () {
                              addTodo(_tc.text);
                              _tc.text = '';
                              _fn.unfocus();
                            })))
              ],
            )),
      ),
    );
  }

  addTodo(String details) {
    int index = 0;
    if (todos.isEmpty) {
      index = 1;
    } else {
      index = todos.last.id + 1;
    }

    if (mounted) {
      setState(() {
        todos.add(Todo(details: details, id: index));
      });
    }
  }

  removeTodo(int index) {
    if (todos.isNotEmpty) {
      for (int i = 0; i < todos.length; i++) {
        if (index == todos[i].id) {
          todos.removeAt(i);
          setState(() {});
        }
      }
    }
  }

  editTodo(String details, int index) {
    _tc.text = details;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit text"),
        content: TextFormField(
          // decoration: const InputDecoration(labelText: "Enter text"),
          maxLines: 5,
          controller: _tc,
          focusNode: _fn,
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (mounted) {
                if (todos.isNotEmpty) {
                  for (int i = 0; i < todos.length; i++) {
                    if (index == todos[i].id) {
                      setState(() {
                        todos[i].details = _tc.text;
                        _tc.text = '';
                      });
                    }
                  }
                }
              }
              Navigator.of(context).pop();
              _fn.unfocus();
            },
            child: const Text('Edit'),
          )
        ],
      ),
    );
  }
}

class Todo {
  String details;
  late DateTime created;
  int id;

  Todo({this.details = '', DateTime? created, this.id = 0}) {
    created == null ? this.created = DateTime.now() : this.created = created;
  }
  // String details;
  // String title;
  // int id;

  // Todo({this.details = '', this.title = '', this.id = 0});
}
