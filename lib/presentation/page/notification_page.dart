import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../locator.dart';
import '../bloc/request_bloc.dart';
import '../shared/theme.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key, required this.uid});

  final String uid;
  static const routeName = '/notificationPage';

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final RequestCubit requestCubit = locator<RequestCubit>();

  @override
  void initState() {
    requestCubit.getRequest(widget.uid);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    requestCubit.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: blackTextStyle,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: StreamBuilder(
        stream: requestCubit.dataStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<DocumentSnapshot> data = snapshot.data!.docs;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Text(data[index]['status']),
                );
              },
            );
          } else {
            return const Center(
              child: Text("No Notifications"),
            );
          }
        },
      ),
    );
  }
}
