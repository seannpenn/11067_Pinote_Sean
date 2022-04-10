import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../screens/todos/todo_model.dart';

class TodoController with ChangeNotifier{
  final Box todoCache = Hive.box('todos');
  List<Todo> data = [];

  TodoController(){
    List result = todoCache.get('todos', defaultValue: []);
  print(result);
    for(var entry in result){
      print(entry);
      data.add(Todo.fromJson(Map<String, dynamic>.from(entry)));
    }
    notifyListeners();
  }

  toggleDone(Todo todo) {
    todo.toggleDone();
    saveDataToCache();
  }

  addTodo(Todo todo) {
    data.add(todo);
    saveDataToCache();
  }

  removeTodo(Todo toBeDeleted) {
    data.remove(toBeDeleted);
    saveDataToCache();
  }

  updateTodo(Todo todo, String newDetails) {
    todo.updateDetails(newDetails);
    saveDataToCache();
  }

  saveDataToCache(){
    List<Map<String,dynamic>> dataToStore = [];

    for(Todo todo in data){
      dataToStore.add(todo.toJson());
    }

    print(dataToStore);
    todoCache.put('todos', dataToStore);
    notifyListeners();
  }
}