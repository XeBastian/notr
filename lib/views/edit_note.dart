import 'package:flutter/material.dart';

class Edit extends StatelessWidget {
  const Edit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit'),
        centerTitle: true,
      ),
      body: Column(
        children: const [
          Text('Edit Todo'),
        ],
      ),
    );
  }
}