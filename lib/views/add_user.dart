import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/model/user_model.dart';

class AddUser extends StatelessWidget {
  AddUser({Key? key}) : super(key: key);
  // textediting controllers for user input
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
      ),
      body:
          // Textfields for user details
          Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TextField(
              controller: _nameController,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Age',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // add user to firestore
          if (_ageController.text.isNotEmpty && _nameController.text.isNotEmpty && _emailController.text.isNotEmpty) {
            addUser(
              User(
                name: _nameController.text,
                email: _emailController.text,
                age: int.parse(_ageController.text),
                timecreated: Timestamp.now(),
              ),
            );
            Navigator.pop(context);
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Error'),
                  content: const Text('Please fill all the fields'),
                  actions: [
                    TextButton(
                      child: const Text('Ok'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            );
          }
        },
        child: const Icon(Icons.done),
      ),
    );
  }

  // add user to firestore function
  addUser(User user) async {
    final docRef = FirebaseFirestore.instance.collection('users').doc();
    await docRef.set(user.toDocument());
  }
}
