import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:schedulle_app/data/datasource/task_remote_data.dart';
import 'package:schedulle_app/domain/entities/task.dart';
import 'package:schedulle_app/domain/repositories/task_repos.dart';

import '../models/task_model.dart';

class TaskRepositoryImpl extends TaskRepos {
  final TaskRemote dataSource;
  final FirebaseFirestore firebaseFirestore;

  TaskRepositoryImpl(
      {required this.dataSource, required this.firebaseFirestore});

  @override
  Future<Either<String, String>> addTask(Tasks task) async {
    try {
      await dataSource.addTask(TaskModel.fromEntity(task));
      return const Right("Taks Successfully submitted");
    } catch (e) {
      return const Left('Task Unseccessfully submitted');
    }
  }

  @override
  Stream<QuerySnapshot> getTasks(String name) {
    return firebaseFirestore
        .collection('tasks')
        .where('userId', isEqualTo: name)
        .snapshots();
  }
}
