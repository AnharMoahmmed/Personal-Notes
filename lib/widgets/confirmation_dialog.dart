import 'package:flutter/material.dart';
import 'package:personal_notes/widgets/note_button.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Do You want to save the NOTE?',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NoteButton(
              lable: 'No',
              onPressed: () => Navigator.pop(context, false),
              isOutLine: true,  
            ),
            SizedBox(width: 8.0),
            NoteButton(
              lable: 'Yes',
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        ),
      ],
    );
  }
}
