import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

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

  Future<void> addTask(Task task) async {
    final state = this.state;
    if (state is! GettedTasksBoardState) return;

    final tasks = state.tasks.toList();
    tasks.add(task);

    try {
      await repository.update(tasks);
      emit(GettedTasksBoardState(tasks: tasks));
    } catch (e) {
      emit(FailureBoardState(message: 'Error when adding task data!'));
    }
  }

  Future<void> deleteTask(Task task) async {
    final state = this.state;
    if (state is! GettedTasksBoardState) return;

    final tasks = state.tasks.toList();
    tasks.remove(task);

    try {
      await repository.update(tasks);
      emit(GettedTasksBoardState(tasks: tasks));
    } catch (e) {
      emit(FailureBoardState(message: 'Error when deleting task data!'));
    }
  }

  Future<void> checkTask(Task task) async {
    final state = this.state;
    if (state is! GettedTasksBoardState) return;

    final tasks = state.tasks.toList();
    final index = tasks.indexOf(task);
    tasks[index] = task.copyWith(isChecked: !task.isChecked);

    try {
      await repository.update(tasks);
      emit(GettedTasksBoardState(tasks: tasks));
    } catch (e) {
      emit(FailureBoardState(message: 'Error when checking a task!'));
    }
  }

  @visibleForTesting
  void addTasksForTest(List<Task> tasks) {
    emit(GettedTasksBoardState(tasks: tasks));
  }
}
