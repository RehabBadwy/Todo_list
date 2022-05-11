import 'package:add_todo_list/home/add_task_bottom.dart';
import 'package:add_todo_list/home/list/list_screen.dart';
import 'package:add_todo_list/home/setting/setting_screen.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {

  static final ROUTE_NAME ='home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int curentIndex=0;

  List<Widget> screen =[
    TaskList(),
    SettingsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text('Route Todo List'),
      ),
      floatingActionButton : FloatingActionButton(
        onPressed: (){
          setState(() {
            showAddTaskSheet(context);
          });
        },
        shape: StadiumBorder(
            side: BorderSide(
                color: Colors.white,
                width: 4
            )
        ),
        elevation: 1.5,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6,
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: curentIndex,
          onTap: (index){
            curentIndex=index;
            setState(() {

            });
          },
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              label: '',
              icon: Icon(Icons.list),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(Icons.settings),
            ),
          ],
        ),
      ),
      body: screen[curentIndex],
    );
  }
}
void showAddTaskSheet(context){
  showModalBottomSheet(
      context: context,
      builder: (buildContext){
        return AddTaskBottomSheet();
      });
}
