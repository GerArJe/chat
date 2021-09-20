import 'package:flutter/material.dart';

import 'package:chat/models/user.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final users = [
    User(uid: '1', name: 'Maria', email: 'test1@test.com', online: true),
    User(uid: '2', name: 'Felipe', email: 'test2@test.com', online: false),
    User(uid: '3', name: 'Fernando', email: 'test3@test.com', online: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My name',
          style: TextStyle(color: Colors.black54),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.black54,
            )),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(Icons.check_circle, color: Colors.blue[400]),
            // child: Icon(Icons.offline_bolt, color: Colors.red),
          )
        ],
      ),
      body: ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (_, i) => ListTile(
                title: Text(users[i].name),
                leading: CircleAvatar(
                  child: Text(users[i].name.substring(0, 2)),
                ),
                trailing: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                      color: users[i].online ? Colors.green[300] : Colors.red,
                      borderRadius: BorderRadius.circular(100)),
                ),
              ),
          separatorBuilder: (_, i) => Divider(),
          itemCount: users.length),
    );
  }
}
