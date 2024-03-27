import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../repositories/objectbox/task_model.dart';

import 'objectbox.g.dart';

class ObjectBoxDatasource {
  late final Store _store;
  late final Box<TaskModel> _taskModelBox;

  ObjectBoxDatasource._create(this._store) {
    _taskModelBox = Box<TaskModel>(_store);
  }

  static Future<ObjectBoxDatasource> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(
      directory: p.join(docsDir.path, 'obx-todo-app'),
    );
    return ObjectBoxDatasource._create(store);
  }

  // Stream<List<TaskModel>> getTasks() {
  //   final builder =
  //       _taskModelBox.query().order(TaskModel_.id, flags: Order.descending);
  //   return builder.watch(triggerImmediately: true).map((query) => query.find());
  // }

  Future<List<TaskModel>> getTasks() async {
    return _taskModelBox.getAllAsync();
  }

  Future<void> deleteAllTasks() async {
    _taskModelBox.removeAllAsync();
  }

  Future<void> putAllTasks(List<TaskModel> tasks) async {
    _taskModelBox.putManyAsync(tasks);
  }
}
