import '../../database/objectbox_datasource.dart';
import '../../models/task.dart';

import '../board_repository.dart';
import './task_model.dart';

final class ObjectBoxBoardRepository implements BoardRepository {
  final ObjectBoxDatasource datasource;

  const ObjectBoxBoardRepository({required this.datasource});

  @override
  Future<List<Task>> fetch() async {
    final models = await datasource.getTasks();
    final tasks = models.map((e) {
      return Task(
        id: e.id,
        description: e.description,
        isCompleted: e.isCompleted,
      );
    }).toList();
    return tasks;
  }

  @override
  Future<List<Task>> update(List<Task> tasks) async {
    final models = tasks.map((e) {
      final model = TaskModel()
        ..isCompleted = e.isCompleted
        ..description = e.description;

      if (e.id > 0) model.id = e.id;
      return model;
    }).toList();

    await datasource.deleteAllTasks();
    await datasource.putAllTasks(models);
    return tasks;
  }
}
