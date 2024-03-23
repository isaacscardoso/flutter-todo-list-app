import 'package:isar/isar.dart';

part 'task_model.g.dart';

@collection
final class TaskModel {
  Id id = Isar.autoIncrement;
  String description = '';
  bool isCompleted = false;
}
