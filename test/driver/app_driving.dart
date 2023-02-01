import 'package:flutter_test_example/simple_note/injection.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_test_example/simple_note/simple_note_app.dart';
import 'package:localstorage/localstorage.dart';

void main() async {
  enableFlutterDriverExtension(
    handler: (val) async {
      if (val != null) {
        await _saveNotes(val);
      }
      return "";
    },
  );
  di.init();
  runApp(const SimpleNoteApp());
}

Future<void> _saveNotes(String noteJson) async {
  final storage = LocalStorage("app");
  await storage.ready;
  storage.setItem("notes", noteJson);
}
