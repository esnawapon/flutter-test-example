import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_example/simple_note/bloc/app_cubit.dart';
import 'package:flutter_test_example/simple_note/helper/collection_ext.dart';
import 'package:flutter_test_example/simple_note/model/note.dart';
import 'package:flutter_test_example/simple_note/widgets/note_item.dart';

class NoteList extends StatelessWidget {
  const NoteList({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppCubit>();
    return SingleChildScrollView(
      child: Container(
        key: const Key("note_list"),
        padding: const EdgeInsets.all(8),
        child: BlocSelector<AppCubit, AppState, List<Note>>(
          selector: (context) => context.notes,
          builder: (context, notes) {
            return Column(
              children: notes
                  .mapIndexed((e, i) => NoteItem(
                        key: Key("note_item_index[$i]"),
                        note: e,
                        onDelete: () => cubit.delete(e.id),
                      ))
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
