import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:schedulle_app/presentation/bloc/task_bloc.dart';
import 'package:schedulle_app/presentation/page/add_task.dart';
import 'package:schedulle_app/presentation/shared/theme.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

import '../../locator.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key, required this.user});
  static const routeName = './schedulePage';

  final User? user;

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  DateTime _selectedDate = DateTime.now();
  List<DateTime> getDatesInMonth(DateTime month) {
    final List<DateTime> dates = [];
    final int daysInMonth = DateTime(month.year, month.month + 1, 0).day;

    for (int i = 1; i <= daysInMonth - month.day; i++) {
      dates.add(DateTime(month.year, month.month, i));
    }

    return dates;
  }

  final TaskCubit taskCubit = locator<TaskCubit>();

  @override
  void initState() {
    super.initState();
    taskCubit.getTasks(widget.user!.uid);
  }

  @override
  void dispose() {
    super.dispose();
    taskCubit.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () async {
                // await context.read<TaskCubit>().addTask(
                //       Tasks(
                //           username: "Ari",
                //           taskTitle: "ngoding",
                //           startDate: "10.00",
                //           endDate: "13.00",
                //           date: DateTime.now().toString(),
                //           description: "ini adalah deskripsi"),
                //     );
                // DocumentSnapshot doc =  await FirebaseFirestore.instance.collection("users").doc("Lor7xbMxHAUoRNGNZydf64kqwZh1").get();
                // print(doc.get('photoUrl'));
                Navigator.of(context).pushNamed(AddTask.routeName);
              },
              child: const Icon(Icons.add),
            ),
          )
        ],
        title: Text(
          DateFormat("MMMM").format(_selectedDate),
          style: blackTextStyle,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: screenSize.height * 0.01,
            ),
            DatePicker(
              DateTime.now(),
              initialSelectedDate: DateTime.now(),
              daysCount: 31,
              onDateChange: (selectedDate) {
                setState(() {
                  _selectedDate = selectedDate;
                });
              },
            ),
            SizedBox(
              height: screenSize.height * 0.03,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: taskCubit.dataStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<DocumentSnapshot> documents = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        DateTime date = DateFormat('yyyy-MM-dd')
                            .parse(documents[index]['date']);
                        final String formatted =
                            DateFormat('yyyy-MM-dd').format(date);

                        final selectedDate =
                            DateFormat('yyyy-MM-dd').format(_selectedDate);
                        if (formatted == selectedDate) {
                          return Container(
                            margin: const EdgeInsets.only(
                                bottom: 10, left: 20, right: 20),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: whiteColor,
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          documents[index]['taskTitle'],
                                          style: blackTextStyle.copyWith(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: screenSize.height * 0.01,
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          documents[index]['description'],
                                          style: greyTextStyle,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      documents[index]['time'],
                                      style: blackTextStyle,
                                    ),
                                    Text(documents[index]['username'])
                                  ],
                                )
                              ],
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Container();
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<String> _getImage(String uid) async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();
    String url = doc.get('imageUrl');

    return url;
  }
}
