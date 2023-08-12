import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedulle_app/domain/usecase/addTask.dart';
import 'package:equatable/equatable.dart';
import 'package:schedulle_app/domain/usecase/getTasks.dart';

import '../../domain/entities/task.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final AddTask _addTask;
  final GetTasks _getTasks;

  final _dataController = StreamController<QuerySnapshot>();

  Stream<QuerySnapshot> get dataStream => _dataController.stream;

  TaskCubit(this._addTask, this._getTasks) : super(TaskInitial());

  Future<void> addTask(Tasks task) async {
    final result = await _addTask.execute(task);

    result.fold((failure) => {emit(TaskError(failure))},
        (data) => {emit(TaskSuccess(data))});
  }

  Future<void> getTasks(String name) async {
    _getTasks.execute(name).listen((data) {
      _dataController.add(data);
    });
  }

  void dispose() {
    _dataController.close();
  }
}
