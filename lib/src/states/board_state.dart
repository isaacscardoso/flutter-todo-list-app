import '../models/task.dart';

sealed class BoardState {}

final class LoadingBoardState implements BoardState {}

final class GettedTasksBoardState implements BoardState {
  final List<Task> tasks;

  GettedTasksBoardState({required this.tasks});
}

final class EmptyBoardState extends GettedTasksBoardState {
  EmptyBoardState() : super(tasks: []);
}

final class FailureBoardState implements BoardState {
  final String message;

  FailureBoardState({required this.message});
}
