import 'package:add_todo_list/edit/edit_screen.dart';
import 'package:add_todo_list/firebase/firebase_utlis.dart';
import 'package:add_todo_list/model/task.dart';
import 'package:add_todo_list/my_theme_data.dart';
import 'package:add_todo_list/utils.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';


class TaskWidget extends StatefulWidget {
  Task task;
  TaskWidget(this.task);

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      closeOnScroll: true,
      startActionPane: ActionPane(
        extentRatio: .2,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) {
              onDeleteAction();
            },
            icon: Icons.delete,
            backgroundColor: Colors.red,
            label: 'Delete',
          )
        ],
      ),
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(context, EditScreen.routeName, arguments:Task);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                color: widget.task.isDone? MyThemeData.colorGreen:Colors.blue,
                width: 2,
                height: 80,
              ),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.task.title,
                          style:widget.task.isDone?
                          TextStyle(
                            fontSize: 25,
                            color: MyThemeData.colorGreen
                          ):
                          TextStyle(fontSize: 25, color: Colors.blue),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.task.description,
                          style:widget.task.isDone?
                          TextStyle(
                            fontSize: 25,
                            color:MyThemeData.colorGreen
                          ):
                          TextStyle(fontSize: 15, color: Colors.black),
                        ),
                      ),
                    ],
                  )),
              InkWell(
                onTap: (){
                  onDoneAction();
                },
                child: widget.task.isDone?
                    Container(
                      margin: EdgeInsets.all(8),
                      child: Text('is Done',
                      style: TextStyle(
                        fontSize: 25,
                        color: MyThemeData.colorGreen
                      ),
                      ),
                    ):
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12), color: Colors.blue),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                  child: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onDeleteAction() {
    showMessage('Are yoy sure Delete', context, () {
      deleteTask(widget.task)
          .then((value) {})
          .catchError((error) {});
    }, 'Yes',
        negActionName: "Cancel",
        negActionCallBack: () {});
  }

  void onDoneAction() {
    showMessage(
      "task done",
      context,
          () {
        doneTask(widget.task).then((value) {

        }).catchError((error) {
          hideLoadingDialog(context);
        });
      },
      'yes',
    );

  }


}
