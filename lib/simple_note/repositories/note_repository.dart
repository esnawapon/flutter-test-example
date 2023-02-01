import 'package:flutter_test_example/simple_note/model/note.dart';

abstract class NoteRepository {
  Future<List<Note>> all();
  Future<Note> update(Note note);
  Future<void> delete(String id);
}
