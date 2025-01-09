import 'package:flutter/material.dart';
import 'package:flutter_test_example/simple_note/injection.dart' as di;
import 'package:flutter_test_example/simple_note/simple_note_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const SimpleNoteApp());
}
