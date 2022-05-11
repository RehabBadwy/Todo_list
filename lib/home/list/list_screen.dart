
import 'package:add_todo_list/firebase/firebase_utlis.dart';
import 'package:add_todo_list/home/list/task_widget.dart';
import 'package:add_todo_list/model/task.dart';

// import 'package:add_todo_list/provider/lis_provider.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';


class TaskList extends StatefulWidget {
  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {

  // late ListProvider provider;
  DateTime selectedDate = DateTime.now();
  List<Task> tasksList = [];
  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   Future.delayed(Duration(milliseconds: 700),(){
  //     provider.getRefresh();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // provider = Provider.of(context);
    // provider.getRefresh();
    return Container(
      child: Column(
        children: [
          CalendarTimeline(
            initialDate:selectedDate,
            lastDate: DateTime.now().add(Duration(days: 365)),
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            onDateSelected: (date) {
              if (date == null) return;
              setState(() {

                selectedDate = date;
               setState(() {

               });
              });
            },
            leftMargin: 20,
            monthColor: Colors.black,
            dayColor: Colors.black,
            activeDayColor: Theme.of(context).primaryColor,
            activeBackgroundDayColor: Colors.white,
            dotsColor: Color(0xFF333A47),
            selectableDayPredicate: (date) => true,
            locale: 'en_ISO',
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Task>>(
                stream: listenFotTask(
                    DateUtils.dateOnly(selectedDate).millisecondsSinceEpoch
                ),
                builder: (buildContext,snapshot){
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator());
                  }
                  else if(snapshot.hasError){
                    return Center(
                      child: Column(
                          children: [
                            Text(snapshot.error.toString()),
                            ElevatedButton(
                                onPressed: (){
                                  setState(() {

                                  });
                                },
                                child: Text("try again")
                            )
                          ]
                      ),
                    );
                  }
                  var data = snapshot.data;
                  var tasksList = data?.docs.map((doc) => doc.data()).toList();
                  return
                    tasksList==null || tasksList.length==0?
                    Center(child: Text('No Tasks for this day')):
                    ListView.builder(
                      itemBuilder: (context,index){
                        return TaskWidget((tasksList.elementAt(index)));
                      },
                      itemCount: (tasksList.length),
                    );
                }),

          ),
        ],
      ),
    );
  }


}

