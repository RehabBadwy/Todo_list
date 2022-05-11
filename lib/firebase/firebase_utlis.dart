import 'package:add_todo_list/model/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

extension MyDateExtension on DateTime{
  DateTime getDateOnly (){
    return DateTime(this.year, this.month, this.day);
  }
}

 CollectionReference<Task> getTasksCollection(){
  return FirebaseFirestore.instance
      .collection('tasks')
      .withConverter<Task>(
      fromFirestore: (docSnapshot,_)=>Task.fromJson(docSnapshot.data()!),
      toFirestore: (task,_)=>task.toJson());
}

Future<void> addTaskToFireStore(Task task){
  var collection = getTasksCollection();
  var newDoc = collection.doc();
  task.id=newDoc.id;
  return newDoc.set(task);
}

Future<QuerySnapshot<Task>> getTasks(int dateTimeInMillis){
  return getTasksCollection()
      .where('dateTime', isEqualTo: dateTimeInMillis)
      .get();
}

Stream<QuerySnapshot<Task>> listenFotTask(int dateTimeInMillis){
  return getTasksCollection()
      .where('dateTime', isEqualTo: dateTimeInMillis)
      .snapshots();
}

Future<void> deleteTask(Task task){
  return getTasksCollection()
      .doc(task.id)
      .delete();
}

 doneTask(Task task){
 CollectionReference todo= getTasksCollection();
 todo.doc(task.id).update({'isDone': task.isDone? false: true});
}

Future<void> EditTask(Task task){
  CollectionReference todo= getTasksCollection();
 return todo.doc(task.id).update({
   'title': task.title,
   'description': task.description,
   'dateTime': task.dateTime
 });
}