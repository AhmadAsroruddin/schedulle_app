import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedulle_app/presentation/bloc/task_bloc.dart';
import 'package:schedulle_app/presentation/page/friends_page.dart';
import 'package:schedulle_app/presentation/page/notification_page.dart';

import 'package:schedulle_app/presentation/page/schedule_page.dart';
import 'package:schedulle_app/presentation/routes/router_delegate.dart';
import 'package:schedulle_app/presentation/shared/theme.dart';
import 'package:intl/intl.dart';

import '../../locator.dart';
import '../bloc/Auth_bloc.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key, required this.user});
  String formatTime = DateFormat("dd MMMM yyyy").format(DateTime.now());
  User? user;

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Welcome, ${user!.displayName}",
                      style: blackTextStyle.copyWith(fontSize: 16),
                    ),
                    TextButton(
                      onPressed: () async {
                        context.read<AuthCubit>().logout();

                        (Router.of(context).routerDelegate as MyRouterDelegate)
                            .logout();
                      },
                      child: const Text("Logout"),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: screen.height * 0.02),
                  height: screen.height * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: blueColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        width: screen.width * 0.3,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: whiteColor,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(user!.photoURL!),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            user!.displayName!,
                            style: whiteTextStyle.copyWith(fontSize: 30),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(FriendsPage.routeName);
                            },
                            child: Text(
                              "Add Friends",
                              style: whiteTextStyle,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatTime,
                      style: blackTextStyle.copyWith(
                          fontSize: 20, fontWeight: medium),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(NotificationPage.routeName);
                      },
                      icon: const Icon(Icons.notifications),
                    )
                  ],
                ),
                SizedBox(
                  height: screen.height * 0.02,
                ),
                Heading(
                  title: "On Going",
                ),
                TaskList(
                  screen: screen,
                  nama: user!.displayName!,
                  userID: user!.uid,
                ),
                Heading(
                  title: "Your Friend",
                ),
                TaskList(
                  screen: screen,
                  nama: user!.displayName!,
                  userID: user!.uid,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TaskList extends StatefulWidget {
  const TaskList(
      {super.key,
      required this.screen,
      required this.nama,
      required this.userID});

  final Size screen;
  final String nama;
  final String userID;

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final TaskCubit taskCubit = locator<TaskCubit>();
  @override
  void initState() {
    super.initState();
    taskCubit.getTasks(widget.userID);
  }

  @override
  void dispose() {
    super.dispose();
    taskCubit.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: taskCubit.dataStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<DocumentSnapshot> documents = snapshot.data!.docs;
          return Container(
            height: widget.screen.height * 0.2,
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: documents.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 200,
                  margin: EdgeInsets.symmetric(
                    horizontal: widget.screen.width * 0.01,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: whiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0,
                        blurRadius: 2,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              width: 30,
                              height: 30,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: blueColor,
                              ),
                            ),
                            Text(
                              documents[index]['taskTitle'],
                              style: blackTextStyle,
                            )
                          ],
                        ),
                        SizedBox(
                          height: widget.screen.height * 0.02,
                        ),
                        Expanded(
                          child: Text(
                            documents[index]['description'],
                          ),
                        ),
                        SizedBox(
                          height: widget.screen.height * 0.02,
                        ),
                        Text(documents[index]['time'])
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

// ignore: must_be_immutable
class Heading extends StatelessWidget {
  Heading({
    required this.title,
    super.key,
  });
  String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(SchedulePage.routeName);
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Text('See More'),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
