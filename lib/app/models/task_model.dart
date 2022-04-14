class TasksModel {
  final int id;
  final String descripticon;
  final DateTime dateTime;
  final bool finished;

  TasksModel({
    required this.id,
    required this.descripticon,
    required this.dateTime,
    required this.finished,
  });

  factory TasksModel.loadFromDB(Map<String, dynamic> task) {
    return TasksModel(
      id: task['id'],
      descripticon: task['descricao'],
      dateTime: DateTime.parse(task['data_hora']),
      finished: task['finalizasdo'] == 1,
    );
  }
}
