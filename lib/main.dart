import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/cubits/board_cubit.dart';
import 'src/pages/board_page.dart';
import 'src/repositories/board_repository.dart';
import 'src/repositories/isar/isar_exporteds.dart';

void main() {
  runApp(const AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider(
          create: (ctx) => IsarDatasource(),
        ),
        RepositoryProvider<BoardRepository>(
          create: (ctx) => IsarBoardRepository(datasource: ctx.read()),
        ),
        BlocProvider(
          create: (ctx) => BoardCubit(repository: ctx.read()),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.blue,
        ),
        home: const BoardPage(),
      ),
    );
  }
}
