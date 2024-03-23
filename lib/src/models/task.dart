import 'package:equatable/equatable.dart';

final class Task extends Equatable {
  final int id;
  final String description;
  final bool isCompleted;

  const Task({
    required this.id,
    required this.description,
    required this.isCompleted,
  });

  @override
  List<Object?> get props => [id, description, isCompleted];

  Task copyWith({
    int? id,
    String? description,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
