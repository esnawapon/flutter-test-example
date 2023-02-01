import 'package:flutter/material.dart';
import 'package:flutter_test_example/simple_note/model/note.dart';

class NoteItem extends StatelessWidget {
  final Note note;
  final void Function() onDelete;

  String get keyName => "note_item_id[${note.id}]";

  const NoteItem({
    super.key,
    required this.note,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      key: Key(keyName),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        note.title,
                        key: Key("${keyName}_title"),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        note.content,
                        key: Key("${keyName}_content"),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  key: Key("${keyName}_delete_button"),
                  icon: const Icon(Icons.delete),
                  onPressed: onDelete,
                ),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: Text(
                note.displayUpdated,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
