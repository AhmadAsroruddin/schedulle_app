import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:schedulle_app/domain/entities/task.dart';
import 'package:schedulle_app/presentation/bloc/task_bloc.dart';
import 'package:schedulle_app/presentation/shared/theme.dart';

import '../shared/customTextFieldTask.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});
  static const routeName = './AddTask';

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();

  DateTime _selectedDate = DateTime.now();
  //repeater
  String _selectedRepeat = "once";
  List<String> repeatOptions = ['once', 'weekly', 'daily'];

  //CONTROLLER
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  //FIREBASE
  FirebaseAuth? auth;

  @override
  void initState() {
    auth = FirebaseAuth.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: lightGreyColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(screenSize.width * 0.1),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomTextFieldTask(
                    textController: _titleController,
                    screenSize: screenSize,
                    hintText: 'Title',
                  ),
                  CustomTextFieldTask(
                    textController: _descriptionController,
                    screenSize: screenSize,
                    hintText: 'description',
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CustomTextFieldTask(
                        screenSize: screenSize,
                        hintText: _startTime,
                        persen: 0.4,
                      ),
                      IconButton(
                        onPressed: () {
                          _getTimeFromUser();
                        },
                        icon: const Icon(Icons.alarm),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CustomTextFieldTask(
                        screenSize: screenSize,
                        hintText: DateFormat.yMd().format(_selectedDate),
                        persen: 0.4,
                      ),
                      IconButton(
                        onPressed: () {
                          _showCalendar();
                        },
                        icon: const Icon(Icons.calendar_month),
                      )
                    ],
                  ),
                  CustomTextFieldTask(
                    screenSize: screenSize,
                    hintText: _selectedRepeat,
                    widget: DropdownButton(
                      underline: Container(),
                      icon: const Icon(
                        Icons.arrow_drop_down, // Dropdown icon
                        color: Colors.white,
                        size: 45,
                      ),
                      items: repeatOptions.map<DropdownMenuItem>(
                        (e) {
                          return DropdownMenuItem(
                            value: e.toString(),
                            child: Text(
                              e.toString(),
                            ),
                          );
                        },
                      ).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedRepeat = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.05,
                  ),
                  Container(
                    width: screenSize.width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: whiteColor,
                    ),
                    child: TextButton(
                      onPressed: () async {
                        await context.read<TaskCubit>().addTask(
                              Tasks(
                                userId: auth!.currentUser!.uid.toString(),
                                username:
                                    auth!.currentUser!.displayName.toString(),
                                taskTitle: _titleController.text,
                                repeat: _selectedRepeat,
                                time: _startTime,
                                date: _selectedDate.toString(),
                                description: _descriptionController.text,
                              ),
                            );
                      },
                      child: Text(
                        "Submit",
                        style: blackTextStyle,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _getTimeFromUser() async {
    var pickedTime = await _showTime();

    String formattedTime =
        MaterialLocalizations.of(context).formatTimeOfDay(pickedTime);

    setState(() {
      _startTime = formattedTime;
    });
  }

  _showTime() {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(_startTime.split(":")[0]),
        minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
      ),
      builder: (context, child) {
        return Theme(
          data: ThemeData().copyWith(
            colorScheme: const ColorScheme.light(primary: Colors.black),
          ),
          child: MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child!),
        );
      },
    );
  }

  Future _showCalendar() async {
    final datePicker = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2060),
    );

    if (datePicker != null) {
      setState(() {
        _selectedDate = datePicker;
      });
    } else {
      print("error");
    }
  }
}
