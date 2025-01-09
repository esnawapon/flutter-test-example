// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_example/simple_note/model/note.dart';
import 'package:flutter_test_example/simple_note/simple_note_app.dart';
import 'package:flutter_test_example/simple_note/injection.dart' as di;
import 'package:localstorage/localstorage.dart';

Future<void> _saveNotes(List<Note> notes) async {
  localStorage.setItem("notes", json.encode(notes.map((e) => e.toJson()).toList()));
}

void main() {
  testWidgets("As a user, I can write my note and I can save it", (tester) async {
    await di.init();
    int i = 0;
    _saveNotes([]);
    await tester.pumpWidget(const SimpleNoteApp());
    await tester.pumpAndSettle();
    final app = find.byKey(const Key("simple_note_app"));

    // start writing
    final writingButton = find.byKey(const Key("writing_button"));
    await expectLater(app, matchesGoldenFile("save/${i++}.png"));
    await tester.tap(writingButton);
    await tester.pumpAndSettle();
    await expectLater(app, matchesGoldenFile("save/${i++}.png"));
    final titleField = find.byKey(const Key("new_note_title_field"));
    final contentField = find.byKey(const Key("new_note_content_field"));
    final saveNoteButton = find.byKey(const Key("save_note_button"));

    // finish writing
    const titleValue = "Shopping list";
    const contentValue = "1 pack of eggs";
    await tester.enterText(titleField, titleValue);
    await tester.enterText(contentField, contentValue);
    await tester.pumpAndSettle();
    await expectLater(app, matchesGoldenFile("save/${i++}.png"));

    // saved
    await tester.tap(saveNoteButton);
    await tester.pumpAndSettle();
    await expectLater(app, matchesGoldenFile("save/${i++}.png"));
  });

  testWidgets("As a user, I can delete my note", (tester) async {
    await di.init();
    int i = 0;
    final initNote = Note(
      id: "TEST_NOTE_01",
      title: "TEST NOTE TITLE",
      content: "TEST_NOTE_CONTENT",
      updated: DateTime.now(),
    );
    _saveNotes([
      initNote,
    ]);
    final noteItemKey = "note_item_id[${initNote.id}]";
    await tester.pumpWidget(const SimpleNoteApp());
    await tester.pumpAndSettle();
    final app = find.byKey(const Key("simple_note_app"));

    // delete
    await expectLater(app, matchesGoldenFile("delete/${i++}.png"));
    final deleteButton = find.byKey(Key("${noteItemKey}_delete_button"));
    expect(deleteButton, findsOneWidget);
    await tester.tap(deleteButton);
    await tester.pumpAndSettle();
    await expectLater(app, matchesGoldenFile("delete/${i++}.png"));
  });
}
