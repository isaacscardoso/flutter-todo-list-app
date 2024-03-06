import 'package:equatable/equatable.dart';

final class Task extends Equatable {
  final int id;
  final String description;
  final bool isChecked;

  const Task({
    required this.id,
    required this.description,
    required this.isChecked,
  });

  @override
  List<Object?> get props => [id, description, isChecked];

  Task copyWith({
    int? id,
    String? description,
    bool? isChecked,
  }) {
    return Task(
      id: id ?? this.id,
      description: description ?? this.description,
      isChecked: isChecked ?? this.isChecked,
    );
  }
}
