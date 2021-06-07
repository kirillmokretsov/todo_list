class Task {
  String id;
  String title;
  int timeAdded;
  int timeEdited;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.timeAdded,
    required this.timeEdited,
    this.isCompleted: false,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'timeAdded': timeAdded,
        'timeEdited': timeEdited,
        'isCompleted': isCompleted,
      };

  static Task fromMap(Map<String, dynamic> map) {
    String id = map['id'] ?? (throw Exception('Map id is null'));
    String title = map['title'] ?? (throw Exception('Map title is null'));
    int timeAdded =
        map['timeAdded'] ?? (throw Exception('Map timeAdded is null'));
    int timeEdited =
        map['timeEdited'] ?? (throw Exception('Map timeEdited is null'));
    bool isCompleted =
        map['isCompleted'] ?? (throw Exception('Map isCompleted is null'));
    return Task(
      id: id,
      title: title,
      timeAdded: timeAdded,
      timeEdited: timeEdited,
      isCompleted: isCompleted,
    );
  }
}
