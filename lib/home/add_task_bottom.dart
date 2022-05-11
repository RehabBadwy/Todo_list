import 'package:add_todo_list/firebase/firebase_utlis.dart';
import 'package:add_todo_list/home/data.dart';
import 'package:add_todo_list/model/task.dart';
import 'package:add_todo_list/provider/lis_provider.dart';
import 'package:add_todo_list/utils.dart';
import 'package:flutter/material.dart';



class AddTaskBottomSheet extends StatefulWidget {

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime  selectedDate = DateTime.now();
  var formController = GlobalKey<FormState>();
  String title = '';
  String desc = '';
  // late ListProvider provider;

  @override
  Widget build(BuildContext context) {
    // provider = Provider.of(context);
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(

            borderRadius: BorderRadius.only(topLeft:Radius.circular(12),topRight:Radius.circular(12))
        ),
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Add Task',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30
                )
            ),
            Form(
                key: formController,
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (text){
                        this.title=text;
                      },
                      validator: (text){
                        if(text==null || text.isEmpty==true){
                          return "please enter title";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Title'
                      ),
                    ),
                    TextFormField(
                      onChanged: (text){
                        this.desc=text;
                      },
                      validator: (text){
                        if(text==null || text.isEmpty==true){
                          return "please enter description";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Description'
                      ),
                      minLines: 4,
                      maxLines: 4,
                    ),
                  ],
                )
            ),
            SizedBox(
              height: 8,
            ),
            Text('Select Date'),
            SizedBox(
              height: 8,
            ),
            InkWell(
                onTap: (){
                  showTaskDatePicker(context);
                },
                child: Text(formateDate('yyyy-MM-dd', selectedDate),
                  textAlign: TextAlign.center,
                )
            ),
            ElevatedButton(
                onPressed: (){
                  addTask();
                  // provider.getRefresh();
                },
                child: Text('Add',

                ))
          ],
        ),
      ),
    );
  }

  void addTask()async{
    if(formController.currentState?.validate() == true)
      showLoading(context, 'Loading');
    Task task = Task(
        title: title,
        description: desc,
        dateTime: DateUtils.dateOnly(selectedDate).millisecondsSinceEpoch);
    addTaskToFireStore(task)
        .then((value){
      hideLoadingDialog(context);
      showMessage('Task Added Successfull', context, () {

      },'OK');
    }).catchError((error){
      hideLoadingDialog(context);
      showMessage('Error can not add task please try again',
          context,
              () {
            hideLoadingDialog(context);
          },
          'ok');
    });
  }

  void showTaskDatePicker(context)async{
    var date = await  showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));

    if(date!=null){
      selectedDate=date;
      setState(() {

      });
    }
  }
}

