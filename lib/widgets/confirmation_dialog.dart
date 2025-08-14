import 'package:flutter/material.dart';
import 'package:personal_notes/widgets/dialog_card.dart';
import 'package:personal_notes/widgets/note_button.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return DialogCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
          title,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NoteButton(
                child:Text('No'),
                onPressed: () => Navigator.pop(context, false),
                isOutLine: true,
              ),
              SizedBox(width: 8.0),
              NoteButton(
                child: Text('Yes'),
                onPressed: () => Navigator.pop(context, true),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
