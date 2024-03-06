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
}
