import 'dart:convert';
import 'package:flutter_test_example/simple_note/model/note.dart';
import "package:gherkin/gherkin.dart";
import "package:flutter_gherkin/flutter_gherkin.dart";

extension StepDriverConnect on StepContext {
  Future<String> requestData(String message) {
    return (world as FlutterWorld).driver!.requestData(message);
  }
}

StepDefinitionGeneric givenNoNote() {
  return given(
    "I never saved any note",
    (context) async {
      await context.requestData("[]");
    },
  );
}

StepDefinitionGeneric givenANote() {
  return given(
    "I have a saved note",
    (context) async {
      await context.requestData(json.encode([
        Note(
          id: "TEST_NOTE_01",
          title: "TEST NOTE TITLE",
          content: "TEST_NOTE_CONTENT",
          updated: DateTime.now(),
        )
      ].map((e) => e.toJson()).toList()));
    },
  );
}
