import 'dart:async';

import '../database/database.dart';
import '../model/task_model.dart';

class TodoDao {
  final dbProvider = DatabaseProvider.dbProvider;

  //Adds new Todo records
  Future<int?> createTodo(Todo todo) async {
    final db = await dbProvider.database;
    var result = db?.insert(todoTABLE, todo.toDatabaseJson());
    return result;
  }

  //Get All Todo items
  //Searches if query string was passed
  Future<List<Todo>> getTodos(
      {List<String>? columns,
      int? isDone,
      String? date,
      bool? isNow,
      String? description}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result = List.empty();
    if (date != null) {
      if ([0, 1].contains(isDone)) {
        if (isNow != null) {
          if (isNow) {
            result = await db!.query(todoTABLE,
                columns: columns,
                where: 'is_done = ? and date = ? and description LIKE ?',
                whereArgs: [isDone, date, "$description%"]);
          } else {
            result = await db!.query(todoTABLE,
                columns: columns,
                where: 'is_done = ? and date != ? and description LIKE ?',
                whereArgs: [isDone, date, "$description%"]);
          }
        } else {
          result = await db!.query(todoTABLE,
              columns: columns, where: 'is_done = ? and description LIKE ?', whereArgs: [isDone,"$description%"]);
        }
      }
    } else {
      result = await db!.query(todoTABLE, columns: columns);
    }

    List<Todo> todos = result.isNotEmpty
        ? result.map((item) => Todo.fromDatabaseJson(item)).toList()
        : [];
    return todos;
  }

  //Update Todo record
  Future<int> updateTodo(Todo todo) async {
    final db = await dbProvider.database;

    var result = await db!.update(todoTABLE, todo.toDatabaseJson(),
        where: "id = ?", whereArgs: [todo.id]);

    return result;
  }

  //Delete Todo records
  Future<int> deleteTodo(String id) async {
    final db = await dbProvider.database;
    var result = await db!.delete(todoTABLE, where: 'id = ?', whereArgs: [id]);

    return result;
  }

  //We are not going to use this in the demo
  Future deleteAllTodos() async {
    final db = await dbProvider.database;
    var result = await db!.delete(
      todoTABLE,
    );

    return result;
  }
}
