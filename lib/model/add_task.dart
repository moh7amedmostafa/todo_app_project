class Task {
  String id;
  String title;
  String description;
  int date;
  bool isDone;

  Task(
      {this.id = '',
      required this.title,
      required this.description,
      required this.date,
      this.isDone = false});

  Task.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'] as String,
            title: json['title'] as String,
            date: json['date'] as int,
            description: json['description'] as String,
            isDone: json['isDone'] as bool);

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'id': id,
      'description': description,
      'date': date,
      'isDone': isDone
    };
  }
}
