import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_example/simple_note/bloc/app_cubit.dart';

class NewNote extends StatelessWidget {
  const NewNote({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppCubit>();
    return Scaffold(
      key: const Key("new_note_page"),
      floatingActionButton: FloatingActionButton(
        key: const Key("save_note_button"),
        onPressed: () {
          cubit.saveNote();
          Navigator.pop(context);
        },
        child: const Icon(Icons.check),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              key: const Key("new_note_title_field"),
              decoration: const InputDecoration(
                hintText: "Title",
                prefixIcon: Icon(Icons.text_snippet_outlined),
              ),
              style: Theme.of(context).textTheme.titleLarge,
              onChanged: cubit.updateTitle,
            ),
            TextField(
              key: const Key("new_note_content_field"),
              autofocus: true,
              decoration: const InputDecoration(
                hintText: "Jot here ...",
                prefixIcon: Icon(Icons.edit_note),
              ),
              minLines: 1,
              maxLines: 5,
              onChanged: cubit.updateContent,
            ),
          ],
        ),
      ),
    );
  }
}
