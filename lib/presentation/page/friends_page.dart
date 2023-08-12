import 'package:flutter/material.dart';
import 'package:schedulle_app/presentation/page/add_friends_page.dart';
import 'package:schedulle_app/presentation/shared/theme.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});
  static const routeName = '/FriendsPage';
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Friend List",
          style: blackTextStyle,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddFriendsPage.routeName);
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return const Card(
              margin: EdgeInsets.all(10),
              child: ListTile(
                contentPadding: EdgeInsets.all(10),
                leading: CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      NetworkImage('https://picsum.photos/250?image=9'),
                ),
                title: Text("Ahmads"),
              ),
            );
          },
        ),
      ),
    );
  }
}
