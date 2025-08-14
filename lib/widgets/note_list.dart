import 'package:flutter/material.dart';
import 'package:personal_notes/models/note.dart';
import 'package:personal_notes/widgets/note_card.dart';

class NotesList extends StatelessWidget {
  const NotesList({super.key, required this.notes});
  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      clipBehavior: Clip.none,
      itemCount: notes.length,
      itemBuilder: (context, indexr) {
        return NoteCard(note: notes[indexr], isInGrid: false);
      },
      separatorBuilder: (context, index) => SizedBox(height: 8),
    );
  }
}
