import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo/controllers/search_controller.dart';
import 'package:todo/model/note_model.dart';
import 'package:todo/model/note_dao.dart';
import 'package:todo/views/add_note.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isSelected = false;
  final List _selectionList = [];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notr'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchController());
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: FirebaseAnimatedList(
          query: NoteDAO().getNoteQuery(),
          itemBuilder: (context, snapshot, animation, int index) {
            final json = Map<String, dynamic>.from(snapshot.value as Map);
            final todo = Note.fromJson(json);
            return Dismissible(
              key: GlobalKey(),
              background: const Align(
                  alignment: Alignment.centerLeft, child: Text('Delete')),
              secondaryBackground: const Align(
                  alignment: Alignment.centerRight, child: Icon(Icons.delete)),
              onDismissed: (value) {
                NoteDAO().deleteNote(snapshot);
              },
              child: ListTile(
                  onLongPress: () {
                    HapticFeedback.heavyImpact();

                    _isSelected = true;
                    _selectionList.add(todo.key);
                    print(_selectionList);
                  },
                  onTap: () {
                    HapticFeedback.selectionClick();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        var titie = TextEditingController(text: todo.title);
                        var subtitie =
                            TextEditingController(text: todo.subtitle);
                        return AlertDialog(
                          title: Text('Edit ${todo.title}'),
                          content: Column(
                            children: [
                              TextFormField(
                                controller: titie,
                                maxLines: 2,
                                decoration: InputDecoration(
                                  hintText: 'Title',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                maxLines: null,
                                controller: subtitie,
                                style: const TextStyle(
                                    overflow: TextOverflow.ellipsis),
                                decoration: InputDecoration(
                                    hintText: 'Subtitle',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7),
                                    )),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                          scrollable: true,
                          actions: [
                            TextButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('Save'),
                              onPressed: () {
                                NoteDAO().updateNote(
                                    snapshot,
                                    Note(
                                      title: titie.text,
                                      subtitle: subtitie.text,
                                    ));
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  title: Text(todo.title),
                  subtitle: Text(todo.subtitle),
                  enableFeedback: true,
                  trailing: _isSelected
                      ? IconButton(
                          icon: const Icon(Icons.check),
                          onPressed: () {
                            NoteDAO().deleteNote(snapshot);
                          },
                        )
                      : IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            NoteDAO().deleteNote(snapshot);
                          },
                        )),
            );
          },
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
              _addTodo(context);
              // print("Hello");
            },
            borderRadius: BorderRadius.circular(10),
            splashColor: const Color.fromARGB(255, 159, 198, 201),
            child: const Center(
              child: Icon(
                Icons.add,
                size: 40,
                color: Color.fromARGB(255, 4, 36, 34),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _addTodo(BuildContext ctx) {
    Navigator.push(
      ctx,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return AddTodo();
        },
      ),
    );
  }
}
