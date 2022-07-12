


import 'dart:async';

import '../model/task_model.dart';
import '../repository/task_repository.dart';

class TodoBloc {
  //Get instance of the Repository
  final _todoRepository = TodoRepository();

  //Stream controller is the 'Admin' that manages
  //the state of our stream of data like adding
  //new data, change the state of the stream
  //and broadcast it to observers/subscribers
  final _todoController = StreamController<List<Todo>>.broadcast();

  get todos => _todoController.stream;

  TodoBloc() {
    getTodos();
  }

  getTodos({int? isDone, String? date , bool? isNow , String? description}) async {
    //sink is a way of adding data reactively to the stream
    //by registering a new event
    _todoController.sink.add(await _todoRepository.getAllTodos(isDone: isDone , date:date ,isNow: isNow , description: description));
  }

  addTodo(Todo todo , int? isDone , String? date , bool? isNow , String? description) async {
    await _todoRepository.insertTodo(todo);
    getTodos(isDone: isDone , date: date ,isNow: isNow , description: description);
  }

  updateTodo(Todo todo , int? isDone , String? date , bool? isNow , String? description) async {
    await _todoRepository.updateTodo(todo);
    getTodos(isDone :isDone, date: date ,isNow: isNow , description: description);

  }

  deleteTodoById(String id , int? isDone , String? date , bool? isNow , String? description) async {
    _todoRepository.deleteTodoById(id);
    getTodos(isDone: isDone , date: date ,isNow: isNow , description:description );

  }

  dispose() {
    _todoController.close();
  }
}
