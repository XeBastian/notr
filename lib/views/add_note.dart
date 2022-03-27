import 'package:flutter/material.dart';
import 'package:todo/model/note_model.dart';
import 'package:todo/model/note_dao.dart';

class AddTodo extends StatelessWidget {
  AddTodo({Key? key}) : super(key: key);
  final _titleController = TextEditingController();
  final _subTitleitleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Note'),
        centerTitle: true,
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                        hintText: 'Title',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                        )),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _subTitleitleController,
                    decoration: InputDecoration(
                        hintText: 'Subtitle',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                        )),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _contentController,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                        hintText: 'Content goes here',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 150,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Center(
                              child: IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {},
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Colors.grey),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Container(
                            child: Center(
                              child: IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {},
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Colors.grey),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Container(
                            child: Center(
                              child: IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {},
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Colors.grey),
                          ),
                        ),
                        const SizedBox(width: 5),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 162, 255, 190)),
        child: Material(
          borderRadius: BorderRadius.circular(10),
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              _titleController.text.isEmpty ||
                      _subTitleitleController.text.isEmpty
                  ? showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return const SizedBox(
                          height: 80,
                          child: Center(
                            child: Text(
                                'ERROR!\nTitle or Subtitle Cannot be Empty',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 205, 201)),
                                textAlign: TextAlign.center),
                          ),
                        );
                      },
                    )
                  : _addNote(context);
            },
            borderRadius: BorderRadius.circular(10),
            splashColor: const Color.fromARGB(255, 159, 198, 201),
            child: const Center(
              child: Icon(
                Icons.done,
                size: 40,
                color: Color.fromARGB(255, 4, 36, 34),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _addNote(context) {
    final todo = Note(
      title: _titleController.text,
      subtitle: _subTitleitleController.text,
    );
    NoteDAO().addNote(todo);
    Navigator.pop(context);
  }
}
