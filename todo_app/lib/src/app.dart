import 'package:flutter/material.dart';
import 'package:todo_app/src/screens/todos/todo_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoHomeScreen(),
    );
  }
}