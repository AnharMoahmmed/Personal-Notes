import 'package:flutter/material.dart';
import 'package:personal_notes/widgets/note_card.dart';

class notesGrid extends StatelessWidget {
  const notesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 15,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
      ),
      itemBuilder: (context, int index) {
        return NoteCard(isInGrid: true);
      },
    );
  }
}
