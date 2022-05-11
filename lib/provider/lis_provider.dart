import 'package:add_todo_list/firebase/firebase_utlis.dart';
import 'package:add_todo_list/model/task.dart';
import 'package:flutter/material.dart';

class ListProvider extends ChangeNotifier{
  DateTime selectedDate = DateTime.now();
  List<Task> tasksList = [];

  void getRefresh(){
    getTasksCollection().where('dateTime', isEqualTo: selectedDate.getDateOnly().millisecondsSinceEpoch )
        .get().then((QuerySnapshotTodo){
     tasksList = QuerySnapshotTodo.docs.map((document){
       return document.data();
      }).toList();
     notifyListeners();
    });
  }

  void newsSelected(DateTime selectedDate){
    this.selectedDate = selectedDate;
    notifyListeners();
  }
}