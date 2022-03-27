import 'package:firebase_database/firebase_database.dart';
import 'package:todo/model/note_model.dart';

class NoteDAO {
  // Firebase RealTime Database Reference
  final DatabaseReference _noteRef =
      FirebaseDatabase.instance.ref().child("note");

// create a Todo Item
  void addNote(Note todo) {
    _noteRef.push().set(todo.toJson());
  }

// Read a Todo item
  Query getNoteQuery() {
    return _noteRef;
  }

// Update a Todo
  void updateNote(DataSnapshot snapshot, Note todo) async {
    await _noteRef.child(snapshot.key!).update(todo.toJson());
  }

  // Delete a Todo
  void deleteNote(DataSnapshot snapshot) {
    _noteRef.child(snapshot.key!).remove();
  }

  void deletAllNotes() async {
    await _noteRef.remove();
  }
  // CRUD Done
}
