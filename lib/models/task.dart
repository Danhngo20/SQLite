class Task {
  final String id;
  String title;
  bool isDone;
  final int createdAt;

  Task({
    required this.id,
    required this.title,
    this.isDone = false,
    required this.createdAt,
  });

  /// Map dùng cho SQLite (sqflite)
  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'is_done': isDone ? 1 : 0,
        'created_at': createdAt,
      };

  factory Task.fromMap(Map<String, dynamic> map) => Task(
        id: map['id'] as String,
        title: map['title'] as String,
        isDone: (map['is_done'] as int) == 1,
        createdAt: map['created_at'] as int,
      );
}
