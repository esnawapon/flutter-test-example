import 'dart:async';
import 'dart:io';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:glob/glob.dart';
import 'steps/steps_setup.dart';

Future<void> main() {
  final dir = Platform.script.path.substring(0, Platform.script.path.lastIndexOf("/"));
  final config = FlutterTestConfiguration()
    ..features = [
      Glob("$dir/features/*.feature")
    ]
    ..reporters = [
      ProgressReporter(),
      TestRunSummaryReporter(),
      JsonReporter(path: "$dir/report.json")
    ]
    ..stepDefinitions = [
      givenNoNote(),
      givenANote(),
    ]
    ..restartAppBetweenScenarios = true
    ..targetAppPath = "$dir/app_driving.dart";
  return GherkinRunner().execute(config);
}
