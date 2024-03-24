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

  testWidgets('board page ...', (tester) async {
    await tester.pumpWidget(
      BlocProvider.value(
        value: cubit,
        child: const MaterialApp(home: BoardPage()),
      ),
    );
  });
}
