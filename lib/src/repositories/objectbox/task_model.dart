import 'package:objectbox/objectbox.dart';

@Entity()
final class TaskModel {
  @Id()
  int id = 0;

  String description = '';
  bool isCompleted = false;
}
