import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedulle_app/domain/entities/request.dart';
import 'package:schedulle_app/locator.dart';
import 'package:schedulle_app/presentation/bloc/Auth_bloc.dart';
import 'package:schedulle_app/presentation/bloc/request_bloc.dart';
import 'package:schedulle_app/presentation/shared/theme.dart';

class AddFriendsPage extends StatefulWidget {
  const AddFriendsPage({super.key});

  static const routeName = './addFriendsPage';

  @override
  State<AddFriendsPage> createState() => _AddFriendsPageState();
}

class _AddFriendsPageState extends State<AddFriendsPage> {
  String searchText = '';
  final AuthCubit authCubit = locator<AuthCubit>();

  @override
  void initState() {
    super.initState();
    authCubit.getUser(searchText);
  }

  @override
  void dispose() {
    super.dispose();
    authCubit.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SearchBar(
                hintText: "Tuliskan nama yang ingin anda cari",
                hintStyle: MaterialStateProperty.all<TextStyle?>(greyTextStyle),
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                    authCubit.getUser(searchText);
                  });
                },
              ),
              const SizedBox(
                height: 12,
              ),
              StreamBuilder(
                stream: authCubit.dataStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          if (snapshot.data!.docs.isEmpty) {
                            return const Center(
                              child: Text("No data"),
                            );
                          } else {
                            List<DocumentSnapshot> documents =
                                snapshot.data!.docs;
                            return BlocConsumer<RequestCubit, RequestState>(
                              listener: (context, state) {
                                print(state);
                              },
                              builder: (context, state) {
                                return Card(
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.all(10),
                                    leading: const CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(
                                          'https://picsum.photos/250?image=9'),
                                    ),
                                    title: Text(documents[index]['username']),
                                    trailing: IconButton(
                                      onPressed: () {
                                        FirebaseAuth firebaseAuth =
                                            FirebaseAuth.instance;
                                        User? user = firebaseAuth.currentUser;

                                        Request req = Request(
                                            penerima:
                                                snapshot.data!.docs[index].id,
                                            pengirim: user!.uid,
                                            status: "requested");

                                        context
                                            .read<RequestCubit>()
                                            .addRequest(req);
                                      },
                                      icon: const Icon(Icons.person_add),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Container();
                  } else {
                    return const Expanded(
                        child: Center(child: CircularProgressIndicator()));
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
