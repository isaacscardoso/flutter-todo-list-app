import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:todo_list_app/src/models/task.dart';
import 'package:todo_list_app/src/cubits/board_cubit.dart';
import 'package:todo_list_app/src/states/board_state.dart';
import 'package:todo_list_app/src/repositories/board_repository.dart';

final class BoardRepositoryMocked extends Mock implements BoardRepository {}

void main() {
  late BoardCubit systemUnderTest;
  late BoardRepository repository;
  late Task task;

  setUp(() {
    repository = BoardRepositoryMocked();
    systemUnderTest = BoardCubit(repository: repository);
    task = const Task(id: 1, description: '', isCompleted: false);
  });

  tearDown(() {
    reset(repository);
    systemUnderTest.close();
  });

  group('fetchTasks', () {
    test('Should fetch all tasks successfully.', () async {
      when(() => repository.fetch()).thenAnswer((_) async => []);

      expect(
        systemUnderTest.stream,
        emitsInOrder([
          isA<LoadingBoardState>(),
          isA<GettedTasksBoardState>(),
        ]),
      );

      await systemUnderTest.fetchTasks();
    });

    test('Should throw an exception when an error occurs.', () async {
      when(() => repository.fetch()).thenThrow(Exception('Error'));

      expect(
        systemUnderTest.stream,
        emitsInOrder([
          isA<LoadingBoardState>(),
          isA<FailureBoardState>(),
        ]),
      );

      await systemUnderTest.fetchTasks();
    });
  });

  group('addTask', () {
    test('Should add a task successfully.', () async {
      when(() => repository.update(any())).thenAnswer((_) async => []);

      expect(
        systemUnderTest.stream,
        emitsInOrder([isA<GettedTasksBoardState>()]),
      );

      await systemUnderTest.addTask(task);
      final state = systemUnderTest.state as GettedTasksBoardState;

      expect(state.tasks.length, equals(1));
      expect(state.tasks, equals([task]));
    });

    test('Should throw an exception when an error occurs.', () async {
      when(() => repository.update(any())).thenThrow(Exception('Error'));

      expect(
        systemUnderTest.stream,
        emitsInOrder([isA<FailureBoardState>()]),
      );

      await systemUnderTest.addTask(task);
    });
  });

  group('deleteTask', () {
    setUp(() {
      systemUnderTest.addTasksForTest([task]);
    });

    test('Should delete a task successfully.', () async {
      when(() => repository.update(any())).thenAnswer((_) async => []);

      expect(
        systemUnderTest.stream,
        emitsInOrder([isA<GettedTasksBoardState>()]),
      );

      final currentState = systemUnderTest.state as GettedTasksBoardState;
      expect(currentState.tasks.length, equals(1));

      await systemUnderTest.deleteTask(task);

      final newState = systemUnderTest.state as GettedTasksBoardState;
      expect(newState.tasks.length, equals(0));
    });

    test('Should throw an exception when an error occurs.', () async {
      when(() => repository.update(any())).thenThrow(Exception('Error'));

      expect(
        systemUnderTest.stream,
        emitsInOrder([isA<FailureBoardState>()]),
      );

      await systemUnderTest.deleteTask(task);
    });
  });

  group('checkTask', () {
    setUp(() {
      systemUnderTest.addTasksForTest([task]);
    });

    test('Should check a task successfully.', () async {
      when(() => repository.update(any())).thenAnswer((_) async => []);

      expect(
        systemUnderTest.stream,
        emitsInOrder([isA<GettedTasksBoardState>()]),
      );

      final currentState = systemUnderTest.state as GettedTasksBoardState;
      expect(currentState.tasks.length, equals(1));
      expect(currentState.tasks.first.isCompleted, isFalse);

      await systemUnderTest.toggleTaskCompletion(task);

      final newState = systemUnderTest.state as GettedTasksBoardState;
      expect(newState.tasks.length, equals(1));
      expect(newState.tasks.first.isCompleted, isTrue);
    });

    test('Should throw an exception when an error occurs.', () async {
      when(() => repository.update(any())).thenThrow(Exception('Error'));

      expect(
        systemUnderTest.stream,
        emitsInOrder([isA<FailureBoardState>()]),
      );

      await systemUnderTest.toggleTaskCompletion(task);
    });
  });
}
