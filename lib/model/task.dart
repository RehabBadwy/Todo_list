class Task{
  String id;
  String title;
  String description;
  int dateTime;
  bool isDone = false;

  Task({this.id='', required this.title,
    required this.description, required this.dateTime,
    this.isDone = false
  });

  Task.fromJson(Map<String,dynamic> json)
      :this(
    id : json['id'] as String,
    title :json['title'] as String,
    description :json['description'] as String,
    dateTime :json['dateTime'] as int,
    isDone :json['isDone'] as bool,
  );

  Map<String,dynamic> toJson(){
    return{
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime,
      'isDone': isDone
    };
  }
}