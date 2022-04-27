import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/model/user_model.dart';
import 'package:todo/views/add_user.dart';

class UserHome extends StatelessWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
        actions: [
          // order items from firebase
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {
              showMenu(context: context, position: const RelativeRect.fromLTRB(10, 10, 0, 0), items: [
                PopupMenuItem(
                  value: 'name',
                  child: const Text('Sort by name'),
                  onTap: () {
                    // sort by name
                    FirebaseFirestore.instance.collection('users').orderBy('name').snapshots();
                  },
                ),
                PopupMenuItem(
                  value: 'age',
                  child: const Text('Sort by age'),
                  onTap: () {
                    FirebaseFirestore.instance.collection('users').orderBy('age').snapshots().listen((snapshot) {
                      final users = snapshot.docs.map((doc) => User.fromDocument(doc)).toList();
                      Navigator.pop(context, users);
                    });
                  },
                ),
              ]);
            },
          ),
        ],
      ),
      body: StreamBuilder<List<User>>(
        stream: getUsers(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // show error message
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final users = snapshot.data;
            return ListView(
              children: users!.map(buildUser).toList(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddUser()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildUser(User user) {
    return ListTile(
      title: Text(user.name!),
      subtitle: Text(user.email!),
      trailing: Text(user.age.toString()),
    );
  }

  // read users from firestore
  Stream<List<User>> getUsers() {
    return FirebaseFirestore.instance
        .collection('users')
        .orderBy('timecreated')
        .snapshots()
        .map((QuerySnapshot snapshot) => snapshot.docs.map((DocumentSnapshot doc) => User.fromDocument(doc)).toList());
  }
}
