import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/board_cubit.dart';
import '../states/board_state.dart';

class BoardPage extends StatefulWidget {
  const BoardPage({super.key});

  @override
  State<BoardPage> createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<BoardCubit>().fetchTasks();
    });
  }

  Widget _buildDefaultStateWidget() {
    return const Center();
  }

  Widget _buildEmptyStateWidget() {
    return const Center(
      key: Key('EmptyState'),
      child: Text('Add a new task.'),
    );
  }

  Widget _buildGettedStateWidget({
    required GettedTasksBoardState state,
    required BoardCubit cubit,
  }) {
    final tasks = state.tasks;
    return ListView.builder(
      key: const Key('GettedState'),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return CheckboxListTile(
          value: task.isCompleted,
          title: Text(task.description),
          onChanged: (value) => cubit.toggleTaskCompletion(task),
        );
      },
    );
  }

  Widget _buildFailureStateWidget() {
    return const Center(
      key: Key('FailureState'),
      child: Text('Error'),
    );
  }

  Widget _assemblePageBody({
    required BoardState state,
    required BoardCubit cubit,
  }) {
    return switch (state) {
      FailureBoardState _ => _buildFailureStateWidget(),
      EmptyBoardState _ => _buildEmptyStateWidget(),
      GettedTasksBoardState _ =>
        _buildGettedStateWidget(state: state, cubit: cubit),
      _ => _buildDefaultStateWidget(),
    };
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<BoardCubit>();
    final state = cubit.state;
    final body = _assemblePageBody(state: state, cubit: cubit);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: body,
    );
  }
}
