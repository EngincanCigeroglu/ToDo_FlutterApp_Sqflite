import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import '../constants/style.dart';
import '../database/database_handler.dart';
import '../models/task.dart';
import 'mytasks_page.dart';

class TaskDetail extends StatefulWidget {
  int? taskId;
  String? taskTitle;
  String? taskDescription;
  int? taskIsDone;
  int? taskPriority;
  String taskDate;

  TaskDetail(
      {required this.taskId,
        required this.taskTitle,
        required this.taskDescription,
        required this.taskIsDone,
        required this.taskPriority,
        required this.taskDate});

  @override
  State<TaskDetail> createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  DatabaseHandler? database_handler;
  late Future<List<Task>> tasks;
  int? selectedOption;
  int? isDonecheck;
  DateTime? dateTime;

  @override
  void initState() {
    super.initState();
    dateTime = DateFormat('dd/MM/yyyy').parse(widget.taskDate);
    titleController.text = widget.taskTitle!;
    descriptionController.text = widget.taskDescription!;
    dateController.text = widget.taskDate;
    selectedOption = widget.taskPriority;
    isDonecheck = widget.taskIsDone;
    database_handler = DatabaseHandler();
    loadData();
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  loadData() async {
    tasks = database_handler!.getTasks();
  }

  void handleRadioValueChange(int? value) {
    setState(() {
      selectedOption = value;
    });
  }

  Widget build(BuildContext context) {
    final currentheight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: Style.pageDecoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: Colors.transparent,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(onPressed:(){
                      Navigator.of(context).pop();
                    }, icon: Icon(Icons.arrow_back_ios_new),color: Colors.white),
                    Container(
                      color: Colors.transparent,
                      alignment: AlignmentDirectional.bottomCenter,
                      height: MediaQuery.of(context).size.height*0.10,
                      padding: EdgeInsetsDirectional.only(bottom: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Task Detail',
                            style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold,
                            )
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 2),
                            height: 2,
                            width: 150,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    )
                  ]
              ),
            ),
            Container(
              height: currentheight-MediaQuery.of(context).size.height*0.10,
              padding: EdgeInsets.only(bottom: 0, top: 7, left: 20, right: 20),
              child: SingleChildScrollView(
                physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                padding: EdgeInsets.only(right: 10, left: 10),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*0.03),
                      Text("Title", style: Style.headStyle),
                      SizedBox(height: MediaQuery.of(context).size.height*0.015),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: Style.fieldDecoration,
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          controller: titleController,
                          onChanged: (newValue) {
                            titleController.text;
                          },
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: 'Enter your title here.',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.03),
                      Text("Description", style: Style.headStyle),
                      SizedBox(height: MediaQuery.of(context).size.height*0.015),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: Style.fieldDecoration,
                        child: TextField(
                          maxLines: 5,
                          style: TextStyle(color: Colors.white),
                          controller: descriptionController,
                          onChanged: (newValue) {
                            descriptionController.text;
                          },
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: 'Enter your description here.',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.03),
                      Text("Priority", style: Style.headStyle),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Theme(
                              data: ThemeData(unselectedWidgetColor: Colors.green),
                              child: RadioListTile<int>(
                                contentPadding: EdgeInsets.zero,
                                title: Transform.translate(
                                  offset: Offset(-22, 0),
                                  child: Text(
                                    'Low',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                value: 1,
                                groupValue: selectedOption,
                                onChanged: handleRadioValueChange,
                                activeColor: Colors.green,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Theme(
                              data: ThemeData(unselectedWidgetColor: Colors.orange),
                              child: RadioListTile<int>(
                                contentPadding: EdgeInsets.zero,
                                title: Transform.translate(
                                  offset: Offset(-22, 0),
                                  child: Text(
                                    'Medium',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                value: 2,
                                groupValue: selectedOption,
                                onChanged: handleRadioValueChange,
                                activeColor: Colors.orange,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Theme(
                              data: ThemeData(unselectedWidgetColor: Colors.red),
                              child: Transform.translate(
                                offset: Offset(20, 0),
                                child: RadioListTile<int>(
                                  contentPadding: EdgeInsets.zero,
                                  title: Transform.translate(
                                    offset: Offset(-22, 0),
                                    child: Text(
                                      'High',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  value: 3,
                                  groupValue: selectedOption,
                                  onChanged: handleRadioValueChange,
                                  activeColor: Colors.red,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.015),
                      Text("Due Date", style: Style.headStyle),
                      SizedBox(height: MediaQuery.of(context).size.height*0.015),
                      Container(
                        decoration: Style.fieldDecoration,
                        child: CupertinoButton(
                          alignment: Alignment.center,
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            _showDateTimePicker();
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.04),
                            child: Text(
                              dateController.text,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),),
          ],
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
            padding: EdgeInsets.symmetric(horizontal: 150, vertical: 12),
            backgroundColor: Color(0xFF000428),
          ),
          child: Text("Save Task", style: TextStyle(color: Colors.white),),
          onPressed: () async {
            if (titleController.text.trim().isEmpty ) {
              Fluttertoast.showToast(
                msg: "Please Enter Title",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.red,
                textColor: Colors.white,
              );
            }else{
              database_handler!.update(Task(
                id: widget.taskId,
                title: titleController.text,
                description: descriptionController.text,
                date: dateController.text,
                priority: selectedOption,
                isDone: isDonecheck,
              ));
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyTasksPage()));
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );

  }

  void _showDateTimePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.35,
        child: CupertinoDatePicker(
          backgroundColor: Colors.white,
          initialDateTime: dateTime,
          onDateTimeChanged: (DateTime newTime) {
            setState(() {
              dateController.text = DateFormat('dd/MM/yyyy').format(newTime);
            });
          },
          use24hFormat: true,
          mode: CupertinoDatePickerMode.date,
        ),
      ),
    );
  }
}
