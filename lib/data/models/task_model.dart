import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/task.dart';

// ignore: must_be_immutable
class TaskModel extends Equatable {
  TaskModel(
      {required this.username,
      required this.taskTitle,
      required this.time,
      required this.date,
      required this.description,
      required this.repeat,
      required this.userId});

  String username;
  String taskTitle;
  String time;
  String repeat;
  String date;
  String description;
  String userId;

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'taskTitle': taskTitle,
      'time': time,
      'date': date,
      'description': description,
      'repeat': repeat,
      'userId': userId
    };
  }

  static Tasks fromMap(Map<String, dynamic> map) {
    return Tasks(
        username: map['username'],
        taskTitle: map['taskTile'],
        time: map['time'],
        repeat: map['repeat'],
        date: map['date'],
        description: map['description'],
        userId: map['userId']);
  }

  factory TaskModel.fromEntity(Tasks task) => TaskModel(
      username: task.username,
      taskTitle: task.taskTitle,
      time: task.time,
      date: task.date,
      description: task.description,
      repeat: task.repeat,
      userId: task.userId);

  factory TaskModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return TaskModel(
        username: data['username'],
        taskTitle: data['taskTitle'],
        time: data['time'],
        date: data['date'],
        description: data['description'],
        repeat: data['repeat'],
        userId: data['userId']);
  }

  Tasks toEntity() {
    return Tasks(
        username: username,
        taskTitle: taskTitle,
        time: time,
        date: date,
        description: description,
        repeat: repeat,
        userId: userId);
  }

  @override
  List<Object?> get props =>
      [username, taskTitle, time, date, description, repeat, userId];
}
