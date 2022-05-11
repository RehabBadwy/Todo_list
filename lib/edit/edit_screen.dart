import 'package:add_todo_list/home/data.dart';
import 'package:add_todo_list/model/task.dart';
import 'package:flutter/material.dart';

import '../firebase/firebase_utlis.dart';

class EditScreen extends StatefulWidget {
 static const String routeName = 'edit';

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
 DateTime  selectedDate = DateTime.now();

 var formController = GlobalKey<FormState>();

 String title = '';

 String desc = '';
 late Task task;

  @override
  Widget build(BuildContext context) {
    task = ModalRoute.of(context)?.settings as Task;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Todo Task',
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold
        ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor
            ),
            height: MediaQuery.of(context).size.height*0.1,
            width: MediaQuery.of(context).size.width,
          ),
          Container(
            margin: EdgeInsets.all(MediaQuery.of(context).size.height*0.2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
            ),
            height: MediaQuery.of(context).size.height*0.8,
            width: MediaQuery.of(context).size.width*0.9,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Text('Add Task',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                        fontWeight: FontWeight.bold
                      )
                  ),
                  Form(
                      key: formController,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(18),
                            child: TextFormField(
                              initialValue: task.title,
                              onChanged: (text){
                                task.title=text;
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
                          ),
                          Container(
                            margin: EdgeInsets.all(18),
                            child: TextFormField(
                              initialValue: task.description,
                              onChanged: (text){
                                task.description=text;
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
                          ),
                        ],
                      )
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    margin: EdgeInsets.all(15),
                      width: double.infinity,
                      child: Text('Select Date')),
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
                  SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)
                      ))
                    ),
                      onPressed: (){
                      edit();
                        // provider.getRefresh();
                      },
                      child: Text('Save Change',
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
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
 void edit(){
   EditTask(task).then((value){
     Navigator.pop(context);
   });
 }
}