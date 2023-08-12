import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedulle_app/domain/repositories/task_repos.dart';


class GetTasks {
  final TaskRepos repos;

  GetTasks({required this.repos});

  Stream<QuerySnapshot> execute(String name) {
    final result = repos.getTasks(name);
  
    return result;
  }
}
