import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Tasks extends Equatable {
  Tasks(
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
  String date;
  String description;
  String repeat;
  String userId;

  @override
  List<Object?> get props =>
      [username, taskTitle, time, date, description, repeat, userId];
}
