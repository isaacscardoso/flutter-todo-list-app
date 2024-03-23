import '../../models/task.dart';
import '../board_repository.dart';
import './isar_datasource.dart';

final class IsarBoardRepository implements BoardRepository {
  final IsarDatasource datasource;

  const IsarBoardRepository({required this.datasource});

  @override
  Future<List<Task>> fetch() async {
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> update(List<Task> tasks) async {
    throw UnimplementedError();
  }
}
