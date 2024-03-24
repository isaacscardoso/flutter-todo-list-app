import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:todo_list_app/src/pages/board_page.dart';
import 'package:todo_list_app/src/cubits/board_cubit.dart';
import 'package:todo_list_app/src/repositories/board_repository.dart';

final class BoardRepositoryMocked extends Mock implements BoardRepository {}

void main() {
  late BoardRepositoryMocked repository;
  late BoardCubit cubit;

  setUp(() {
    repository = BoardRepositoryMocked();
    cubit = BoardCubit(repository: repository);
  });

  testWidgets('Should find a list of tasks on the BoardPage.', (tester) async {
    when(() => repository.fetch()).thenAnswer((_) async => []);

    await tester.pumpWidget(
      BlocProvider.value(
        value: cubit,
        child: const MaterialApp(home: BoardPage()),
      ),
    );

    expect(find.byKey(const Key('EmptyState')), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('GettedState')), findsOneWidget);
  });

  testWidgets('Should throw an exception on the BoardPage.', (tester) async {
    when(() => repository.fetch()).thenThrow((_) async => Exception('Error'));

    await tester.pumpWidget(
      BlocProvider.value(
        value: cubit,
        child: const MaterialApp(home: BoardPage()),
      ),
    );

    expect(find.byKey(const Key('EmptyState')), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('FailureState')), findsOneWidget);
  });
}
