import 'dart:convert';

import 'package:flutter_test_example/simple_note/model/note.dart';
import 'package:flutter_test_example/simple_note/repositories/note_repository.dart';
import 'package:localstorage/localstorage.dart';
import 'package:uuid/uuid.dart';

const _itemKey = "notes";

class LocalNoteRepository implements NoteRepository {
  final _uuid = const Uuid();

  @override
  Future<List<Note>> all() async {
    try {
      return json
          .decode(localStorage.getItem(_itemKey) ?? "") //
          .map<Note>((e) => Note.fromJson(e))
          .toList();
    } catch (e) {
      return <Note>[];
    }
  }

  @override
  Future<void> delete(String id) async {
    final notes = await all();
    notes.removeWhere((e) => e.id == id);
    return _saveAll(notes);
  }

  @override
  Future<Note> update(Note note) async {
    final notes = await all();
    if (note.id.isEmpty) {
      note = note.copyWith(id: _uuid.v4());
    } else {
      notes.removeWhere((e) => e.id == note.id);
    }
    notes.insert(0, note);
    await _saveAll(notes);
    return note;
  }

  Future<void> _saveAll(List<Note> notes) async {
    localStorage.setItem(
      _itemKey,
      json.encode(notes.map((e) => e.toJson()).toList()),
    );
  }
}
