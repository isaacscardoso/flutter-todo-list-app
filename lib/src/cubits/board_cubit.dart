import 'package:bloc/bloc.dart';

import '../models/task.dart';
import '../states/board_state.dart';
import '../repositories/board_repository.dart';

final class BoardCubit extends Cubit<BoardState> {
  final BoardRepository repository;

  BoardCubit({required this.repository}) : super(EmptyBoardState());

  Future<void> fetchTasks() async {
    emit(LoadingBoardState());
    try {
      final tasks = await repository.fetch();
      emit(GettedTasksBoardState(tasks: tasks));
    } catch (e) {
      emit(FailureBoardState(message: 'Error when loading task data!'));
    }
  }

  Future<void> addTask(Task task) async {}

  Future<void> deleteTask(Task task) async {}

  Future<void> checkTask(Task task) async {}
}
