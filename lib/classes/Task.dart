class Task {
  final int taskId;
  final String tsName;
  final int? serial;

  Task({
    required this.taskId,
    required this.tsName,
    this.serial,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      taskId: json['Task_ID'],
      tsName: json['TS_Name'],
      serial: json['Serial'],
    );
  }
}
