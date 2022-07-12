

import '../dao/task_dao.dart';
import '../model/task_model.dart';

class TodoRepository {
  final todoDao = TodoDao();

  Future getAllTodos({int? isDone , String? date , bool? isNow , String? description}) => todoDao.getTodos(isDone: isDone,date:date ,isNow: isNow , description:description);

  Future insertTodo(Todo todo) => todoDao.createTodo(todo);

  Future updateTodo(Todo todo) => todoDao.updateTodo(todo);

  Future deleteTodoById(String id) => todoDao.deleteTodo(id);

  //We are not going to use this in the demo
  Future deleteAllTodos() => todoDao.deleteAllTodos();
}
