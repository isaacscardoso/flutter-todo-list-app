import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_list_app/src/database/objectbox_datasource.dart';
import 'package:todo_list_app/src/models/task.dart';

import 'package:todo_list_app/src/repositories/board_repository.dart';
import 'package:todo_list_app/src/repositories/objectbox/task_model.dart';
import 'package:todo_list_app/src/repositories/objectbox/object_box_board_repository.dart';

final class ObjectBoxDatasourceMocked extends Mock
    implements ObjectBoxDatasource {}

void main() {
  late ObjectBoxDatasource datasource;
  late BoardRepository systemUnderTest;

  setUp(() {
    datasource = ObjectBoxDatasourceMocked();
    systemUnderTest = ObjectBoxBoardRepository(datasource: datasource);
  });

  test('fetch', () async {
    when(() => datasource.getTasks()).thenAnswer((_) async {
      return [
        TaskModel()..id = 1,
      ];
    });

    final tasks = await systemUnderTest.fetch();
    expect(tasks.length, equals(1));
  });

  test('update', () async {
    when(() => datasource.deleteAllTasks()).thenAnswer((_) async => []);
    when(() => datasource.putAllTasks(any())).thenAnswer((_) async => []);

    final tasks = await systemUnderTest.update(const [
      Task(id: -1, description: '', isCompleted: false),
      Task(id: 2, description: '', isCompleted: false),
    ]);
    expect(tasks.length, equals(2));
  });
}
