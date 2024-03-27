import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/repositories/objectbox/object_box_board_repository.dart';
import 'src/repositories/board_repository.dart';
import 'src/database/objectbox_datasource.dart';
import 'src/cubits/board_cubit.dart';
import 'src/pages/board_page.dart';

late final ObjectBoxDatasource objectbox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  objectbox = await ObjectBoxDatasource.create();

  runApp(const AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider(
          create: (ctx) => objectbox,
        ),
        RepositoryProvider<BoardRepository>(
          create: (ctx) => ObjectBoxBoardRepository(datasource: ctx.read()),
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
