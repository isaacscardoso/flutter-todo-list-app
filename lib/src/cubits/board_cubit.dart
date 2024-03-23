import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../models/task.dart';
import '../states/board_state.dart';
import '../repositories/board_repository.dart';

final class BoardCubit extends Cubit<BoardState> {
  final BoardRepository repository;

  BoardCubit({required this.repository}) : super(EmptyBoardState());

  List<Task>? get _tasks {
    final state = this.state;
    if (state is! GettedTasksBoardState) return null;

    return state.tasks.toList();
  }

  Future<void> _emitUpdatedTasks(List<Task> tasks, String requesterDesc) async {
    try {
      await repository.update(tasks);
      emit(GettedTasksBoardState(tasks: tasks));
    } catch (e) {
      emit(FailureBoardState(message: 'Error when $requesterDesc task data!'));
    }
  }

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
    final tasks = _tasks;

    if (tasks == null) return;

    tasks.add(task);

    await _emitUpdatedTasks(tasks, 'adding');
  }

  Future<void> deleteTask(Task task) async {
    final tasks = _tasks;

    if (tasks == null) return;

    tasks.remove(task);

    await _emitUpdatedTasks(tasks, 'deleting');
  }

  Future<void> toggleTaskCompletion(Task task) async {
    final tasks = _tasks;

    if (tasks == null) return;

    final index = tasks.indexOf(task);

    tasks[index] = task.copyWith(isCompleted: !task.isCompleted);

    await _emitUpdatedTasks(tasks, 'toggling completion');
  }

  @visibleForTesting
  void addTasksForTest(List<Task> tasks) {
    emit(GettedTasksBoardState(tasks: tasks));
  }
}
