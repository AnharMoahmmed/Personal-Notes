import 'package:flutter/material.dart';
import 'package:personal_notes/models/note.dart';
import 'package:personal_notes/widgets/note_card.dart';

class notesGrid extends StatelessWidget {
  const notesGrid({required this.notes, super.key});

  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: notes.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
      ),
      itemBuilder: (context, int index) {
        return NoteCard(isInGrid: true, note: notes[index],);
      },
    );
  }
}
