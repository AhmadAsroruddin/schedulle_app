import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:schedulle_app/domain/entities/task.dart';

abstract class TaskRepos {
  Future<Either<String, String>> addTask(Tasks task);
  Stream<QuerySnapshot> getTasks(String name);
}
