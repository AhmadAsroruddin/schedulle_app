import 'package:dartz/dartz.dart';
import 'package:schedulle_app/domain/entities/task.dart';
import 'package:schedulle_app/domain/repositories/task_repos.dart';

class AddTask {
  final TaskRepos repos;

  AddTask({required this.repos});

  Future<Either<String, String>> execute(
      Tasks task) {
    return repos.addTask(task);
  }
}
