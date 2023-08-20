import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoapp_flutter_sqlite/pages/taskdetail_page.dart';
import '../constants/style.dart';
import '../database/database_handler.dart';
import '../models/task.dart';

import 'addtask_page.dart';

class MyTasksPage extends StatefulWidget {
  const MyTasksPage({Key? key}) : super(key: key);

  @override
  State<MyTasksPage> createState() => _MyTasksPageState();
}

class _MyTasksPageState extends State<MyTasksPage> {


  DatabaseHandler? database_handler;
  late Future<List<Task>> tasks;

  @override
  void initState() {
    super.initState();
    database_handler = DatabaseHandler();
    loadData();


  }

  loadData() async {
    tasks = database_handler!.getTasks();
    tasks.then((taskList) {
    });
  }



  @override
  Widget build(BuildContext context) {
    final currentheight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
          decoration: Style.pageDecoration,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                color: Colors.transparent,
                alignment: AlignmentDirectional.bottomCenter,
                height: MediaQuery.of(context).size.height*0.1,
                padding: EdgeInsetsDirectional.only(bottom: 5),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'My Tasks',
                      style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 2),
                      height: 2,
                      width: 200,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              Container(
                height: currentheight-MediaQuery.of(context).size.height*0.1,
                padding: EdgeInsets.only(bottom: 0, top: 7, left: 20, right: 20),
                child: FutureBuilder(
                      future: tasks,
                      builder:(context, AsyncSnapshot<List<Task>> snapshot) {
                        if(!snapshot.hasData || snapshot.data == null){
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        else if(snapshot.data!.length == 0)
                        {
                          return Center(
                            child: Text("You Have Nothing To-Do" , style: Style.headStyle,
                            ),
                          );
                        }
                        else{
                          return ListView.builder(
                              physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                int task_id = snapshot.data![index].id!.toInt();
                                String task_title = snapshot.data![index].title!.toString();
                                String task_description = snapshot.data![index].description!.toString();
                                String task_date = snapshot.data![index].date!.toString();
                                int task_priority = snapshot.data![index].priority!.toInt();
                                int task_isDone = snapshot.data![index].isDone!;

                                return Dismissible(
                                  key: ValueKey<int>(task_id),
                                  direction: DismissDirection.endToStart,
                                  onDismissed: (_) {
                                    setState(() {
                                      database_handler!.delete(task_id);
                                      tasks = database_handler!.getTasks();
                                      snapshot.data!.remove(snapshot.data![index]);
                                      setState(() {
                                        loadData();
                                      });
                                    });
                                  },
                                  background: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    alignment: Alignment.centerRight,
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                  confirmDismiss: (direction) async {
                                    if (direction == DismissDirection.endToStart) {
                                      return await showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10.0),),
                                              title: Text("Delete", style: TextStyle(color: Colors.grey)),
                                              content: Text("Are you sure you want to delete this task?"),
                                              actions: <Widget>[
                                                TextButton(
                                                    onPressed: () =>
                                                        Navigator.of(context).pop(true),
                                                    child: Text("Yes", style: TextStyle(color: Colors.green),)),
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.of(context).pop(false),
                                                  child: Text("No", style: TextStyle(color: Colors.red),),),
                                              ],
                                            );
                                          });
                                    }
                                  },
                                  child: Card(
                                    color: Colors.transparent,
                                    shadowColor: Colors.white24,
                                    margin: EdgeInsetsDirectional.only(bottom: MediaQuery.of(context).size.height * 0.02),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),side: BorderSide(color: Colors.transparent, width: 3),),
                                    child: Container(
                                      decoration: SelectCardDecoration(task_priority),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.symmetric(vertical: 10),
                                        child: ListTile(
                                          onTap: () async {
                                            Navigator.push(context, MaterialPageRoute(
                                              builder: (context) => TaskDetail(
                                                  taskId:task_id,
                                                  taskTitle:task_title,
                                                  taskDescription:task_description,
                                                  taskIsDone:task_isDone,
                                                  taskPriority:task_priority,
                                                  taskDate:task_date),
                                            ));
                                          },
                                          isThreeLine: true,
                                          title: Transform.translate(offset: Offset(0, -8),
                                              child: Text(task_title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white))),
                                          subtitle: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Transform.translate( offset: Offset(0,0),
                                                child: Text(task_description, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white60),
                                                ),),
                                              SizedBox(height: 2,),
                                              Row(
                                                children: [
                                                  Transform.translate( offset: Offset(0,12),
                                                    child: Text("Due Date: ", maxLines: 1,
                                                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white60),
                                                    ),),
                                                  Transform.translate( offset: Offset(0,12),
                                                    child: Text(task_date,
                                                      maxLines: 1,
                                                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white60),
                                                    ),),
                                                ],
                                              )
                                            ],
                                          ),
                                          trailing: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              if (task_isDone == 0)
                                                GestureDetector(
                                                  onTap: () {
                                                    //_showCompletedDialog(context);
                                                    setState(() {
                                                      snapshot.data![index].isDone = 1;
                                                      database_handler!.update(Task(
                                                        id: task_id,
                                                        title: task_title,
                                                        description: task_description,
                                                        date: task_date,
                                                        priority: task_priority,
                                                        isDone: 1,
                                                      ));
                                                    });
                                                  },
                                                  child: Icon(Icons.task_alt, size: 35,
                                                      color: Colors.white),
                                                ),
                                              if (task_isDone == 1)
                                                Text("Completed", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                            ],
                                          ),
                                        ),
                                      ),),

                                  ),
                                );
                              }
                          );
                        }
                      },
                    ),
              )
            ],
          )

      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTask(),
              ));

        },
        splashColor: Colors.transparent,
        backgroundColor: Colors.white,
        child: const Icon(
            Icons.add, color: Color(0xFF000428), size: 40),
      ),
    );
  }


  BoxDecoration SelectCardDecoration(int selectedOption) {
    if (selectedOption == 1) {
      return Style.cardDecorationLow;
    } else if (selectedOption == 2) {
      return Style.cardDecorationMedium;
    } else if (selectedOption == 3) {
      return Style.cardDecorationHigh;
    } else {
      return Style.cardDecorationLow;
    }
  }

}
