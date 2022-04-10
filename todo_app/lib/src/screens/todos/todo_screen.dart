import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/src/controllers/todo_controller.dart';
import 'package:todo_app/src/screens/login/auth_controller.dart';
// import 'package:todo_app/src/screens/todos/home.dart';
import 'package:todo_app/src/screens/todos/todo_model.dart';
import 'package:todo_app/src/screens/todos/widgets/input_widget.dart';
import 'package:todo_app/src/screens/todos/widgets/todo_card.dart';

class TodoHomeScreen extends StatefulWidget {
  const TodoHomeScreen(AuthController authController, {Key? key}) : super(key: key);

  @override
  State<TodoHomeScreen> createState() => _TodoHomeScreenState();
}

class _TodoHomeScreenState extends State<TodoHomeScreen> {
  final TodoController _todoController = TodoController();
  final ScrollController _sc = ScrollController();
  bool _confirm = false;

  @override
  void initState() {
    _todoController.addListener(newTodoListener);
    super.initState();
  }

  newTodoListener(){
    print('Hey I heard that you added a todo!');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Todos App'),
      ),
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: FloatingActionButton(
          // backgroundColor: const Color(0xFF303030),
          backgroundColor: Colors.blueAccent,
          child: const Icon(
            Icons.add,
            size: 30.0,
          ),
          onPressed: () {
            showAddDialog(context);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // backgroundColor: Colors.blueAccent,
      body: SafeArea(
        child: AnimatedBuilder(
          // padding: const EdgeInsets.all(12.0),
          animation: _todoController,
          builder: (BuildContext context, Widget? child) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Expanded(
                    child: Scrollbar(
                      controller: _sc,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(12.0),
                        controller: _sc,
                        child: Column(
                          children: [
                            // for (Todo todo in _todoController.data)
                            // Padding(
                            //   padding: const EdgeInsets.all(2.0),
                            //   child: ListTile(
                            //       tileColor: Colors.white,
                            //       leading: Text(todo.id.toString()),
                            //       title: Text(todo.created.toString()),
                            //       subtitle: Text(todo.details),
                            //       trailing: Row(
                            //         mainAxisSize: MainAxisSize.min,
                            //         children: [
                            //           IconButton(
                            //             icon: const Icon(Icons.edit),
                            //             onPressed: () {
                            //               // editTodo(todo.details, todo.id);
                            //             },
                            //           ),
                            //           IconButton(
                            //             icon: const Icon(Icons.delete),
                            //             onPressed: () {
                            //               // removeTodo(todo.id);
                            //             },
                            //           ),
                            //         ],
                            //       )),
                            // )

                            for (Todo todo in _todoController.data)
                              TodoCard(
                                margin: const EdgeInsets.only(top: 10),
                                todo: todo,
                                onTap: () {
                                  _todoController.toggleDone(todo);
                                },
                                onErase: () {
                                  confirmDeleteDialog(context, todo);
                                  // if(_confirm){
                                  // _todoController.removeTodo(todo);
                                  // }
                                  
                                },
                                onClick: () {
                                  print('Hello sound check!');
                                  showEditDialog(context, todo);
                                },
                              )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  showAddDialog(BuildContext context) async {
    Todo? result = await showDialog<Todo>(
        context: context,
        //if you don't want issues on navigator.pop, rename the context in the builder to something other than context
        builder: (dContext) {
          return const Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16.0),
              ),
            ),
            child: InputWidget(),
          );
        });
    if (result != null) {
      _todoController.addTodo(result);
    }
  }

  showEditDialog(BuildContext context, Todo todo) async {
    Todo? result = await showDialog<Todo>(
        context: context,
        //if you don't want issues on navigator.pop, rename the context in the builder to something other than context
        builder: (dContext) {
          return Dialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16.0),
              ),
            ),
            child: InputWidget(
              current: todo.details,
            ),
          );
        });
    if (result != null) {
      _todoController.updateTodo(todo, result.details);
    }
  }

  void confirmDeleteDialog(BuildContext context, Todo todo) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Please Confirm'),
            content: const Text('Delete this todo?'),
            actions: [
              // The "Yes" button
              TextButton(
                  onPressed: () {
                    // Remove the box
                    setState(() {
                      _confirm = true;
                    });
                    if(_confirm){
                      _todoController.removeTodo(todo);
                    }
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text('Yes')),
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    setState(() {
                      _confirm = false;
                    });
                    Navigator.of(context).pop();

                  },
                  child: const Text('No'))
            ],
          );
        });
  }
}
      
            // child: 
                // TextFormField(
                //     controller: _tc,
                //     focusNode: _fn,
                //     maxLines: 5,
                //     decoration: InputDecoration(
                //         fillColor: Colors.white,
                //         filled: true,
                //         hintText: "Enter description..",
                //         focusedBorder: const OutlineInputBorder(),
                //         enabledBorder: const OutlineInputBorder(),
                //         contentPadding: const EdgeInsets.symmetric(
                //             horizontal: 16, vertical: 8),
                //         prefix: IconButton(
                //           icon: const Icon(Icons.cancel, color: Colors.black),
                //           onPressed: () {
                //             _fn.unfocus();
                //           },
                //         ),
                //         suffix: IconButton(
                //             icon: const Icon(Icons.chevron_right_rounded,
                //                 color: Colors.black),
                //             onPressed: () {
                //               addTodo(_tc.text);
                //               _tc.text = '';
                //               _fn.unfocus();