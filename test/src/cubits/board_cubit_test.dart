import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:todo_list_app/src/cubits/board_cubit.dart';
import 'package:todo_list_app/src/states/board_state.dart';
import 'package:todo_list_app/src/repositories/board_repository.dart';

final class BoardRepositoryMocked extends Mock implements BoardRepository {}

void main() {
  late BoardCubit systemUnderTest;
  late BoardRepository repository;

  setUp(() {
    repository = BoardRepositoryMocked();
    systemUnderTest = BoardCubit(repository: repository);
  });

  tearDown(() => reset(repository));

  group('fetchTasks', () {
    test('Should fetch all tasks.', () async {
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
}
