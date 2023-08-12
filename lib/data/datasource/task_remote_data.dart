import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedulle_app/data/models/task_model.dart';


abstract class TaskRemote {
  Future<void> addTask(TaskModel task);
}

class TaskRemoteImpl extends TaskRemote {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('tasks');
  @override
  Future<void> addTask(TaskModel task) async {
    return await collection
        .add(task.toMap())
        .then(
          (value) => print('Data added successfully'),
        )
        .catchError(
          (error) => print('Failed to add data $error'),
        );
  }
}
