import 'package:flutter/material.dart';
import 'package:flutter_test_example/simple_note/widgets/landing_app_bar.dart';
import 'package:flutter_test_example/simple_note/widgets/note_list.dart';
import 'package:flutter_test_example/simple_note/widgets/writing_button.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      key: Key("landing_page"),
      appBar: LandingAppBar(),
      floatingActionButton: WritingButton(),
      body: SafeArea(
        child: NoteList(),
      ),
    );
  }
}
