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
    _saveNotes([]);
    await tester.pumpWidget(const SimpleNoteApp());
    await tester.pumpAndSettle();

    // start writing
    final writingButton = find.byKey(const Key("writing_button"));
    expect(writingButton, findsOneWidget);
    await tester.tap(writingButton);
    await tester.pumpAndSettle();
    final newNotePage = find.byKey(const Key("new_note_page"));
    expect(newNotePage, findsOneWidget);
    final titleField = find.byKey(const Key("new_note_title_field"));
    final contentField = find.byKey(const Key("new_note_content_field"));
    final saveNoteButton = find.byKey(const Key("save_note_button"));
    expect(titleField, findsOneWidget);
    expect(contentField, findsOneWidget);
    expect(saveNoteButton, findsOneWidget);

    // finish writing
    const titleValue = "Shopping list";
    const contentValue = "1 pack of eggs";
    await tester.enterText(titleField, titleValue);
    await tester.enterText(contentField, contentValue);
    await tester.pumpAndSettle();
    expect(find.descendant(of: titleField, matching: find.text(titleValue)), findsOneWidget);
    expect(find.descendant(of: contentField, matching: find.text(contentValue)), findsOneWidget);

    // saved
    await tester.tap(saveNoteButton);
    await tester.pumpAndSettle();
    expect(newNotePage, findsNothing);
    await tester.pumpAndSettle();
    final noteItem = find.byKey(const Key("note_item_index[0]"));
    final titleLabel = find.descendant(of: noteItem, matching: find.text(titleValue));
    final contentLabel = find.descendant(of: noteItem, matching: find.text(contentValue));
    expect(titleLabel, findsOneWidget);
    expect(contentLabel, findsOneWidget);
  });

  testWidgets("As a user, I can delete my note", (tester) async {
    await di.init();
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

    // delete
    final deleteButton = find.byKey(Key("${noteItemKey}_delete_button"));
    expect(deleteButton, findsOneWidget);
    await tester.tap(deleteButton);
    await tester.pumpAndSettle();
    expect(find.byKey(Key(noteItemKey)), findsNothing);
  });
}
