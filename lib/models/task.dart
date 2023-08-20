import 'dart:convert';

class Task{

  int? id;
  String? title;
  String? description;
  int? isDone;
  int? priority;
  String? date;

  Task({this.id, this.title, this.description, this.isDone, this.priority, this.date});

  Task.fromMap(Map <String, dynamic> res):
        id = res['id'],
        title = res['title'],
        description = res['description'],
        isDone = res['isDone'],
        priority = res['priority'],
        date = res['date'];

  Map<String, Object?> toMap()
  {
    return{
      "id":id,
      "description":description,
      "title": title,
      "isDone": isDone,
      "priority": priority,
      "date": date,
    };
  }
}
