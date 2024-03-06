import 'package:bloc/bloc.dart';

import '../models/task.dart';
import '../states/board_state.dart';

final class BoardCubit extends Cubit<BoardState> {
  BoardCubit() : super(EmptyBoardState());

  Future<void> fetchTasks() async {}

  Future<void> addTask(Task task) async {}

  Future<void> deleteTask(Task task) async {}

  Future<void> checkTask(Task task) async {}
}
