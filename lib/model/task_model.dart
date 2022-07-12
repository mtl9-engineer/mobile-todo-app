

class Todo {
  String id ; 
  String date;
  String time;
  String taskType;
  String description;
  int colorValue;
  bool isDone = false;


  Todo({required this.id ,required this.date ,required this.time, required this.taskType ,required this.description,required this.colorValue ,this.isDone = false});


  factory Todo.fromDatabaseJson(Map<String, dynamic> data) => Todo(

        id: data['id'],
        date:data['date'],
        time: data['time'],
        taskType: data['taskType'],
        description: data['description'],
        colorValue: data['colorValue'],
        isDone: data['is_done'] == 0 ? false : true,
      );

  Map<String, dynamic> toDatabaseJson() => {
    
        "id": id,
        "date" : date,
        "time" : time,
        "taskType" : taskType,
        "description": description,
        "colorValue" : colorValue,
        "is_done": isDone == false ? 0 : 1,
      };
}
