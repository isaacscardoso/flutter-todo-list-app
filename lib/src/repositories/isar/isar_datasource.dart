import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import './task_model.dart';

class IsarDatasource {
  Isar? _isar;

  Future<Isar> _getInstance() async {
    if (_isar != null) return _isar!;
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open([TaskModelSchema], directory: dir.path);
    return _isar!;
  }

  Future<List<TaskModel>> getTasks() async {
    final isar = await _getInstance();
    final data = await isar.taskModels.where().findAll();
    return data;
  }

  Future<void> deleteAllTasks() async {
    final isar = await _getInstance();
    await isar.writeTxn(() => isar.taskModels.where().deleteAll());
  }

  Future<void> putAllTasks(List<TaskModel> tasks) async {
    final isar = await _getInstance();
    await isar.writeTxn(() => isar.taskModels.putAll(tasks));
  }
}
