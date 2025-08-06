import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_notes/core/constans.dart';
import 'package:personal_notes/models/note.dart';
import 'package:personal_notes/pages/new_or_edit_note.dart';

class NoteCard extends StatelessWidget {
  NoteCard({required this.isInGrid, required this.note , super.key});
  bool isInGrid = true;
  final Note note;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewOrEidtNote(isNewnNote: false),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: primary, width: 1.0),
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: primary.withOpacity(0.5),
              offset: const Offset(4, 4),
            ),
          ],
        ),
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'This is going to be a title ',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: gray900,
              ),
            ),
            SizedBox(height: 4),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  3,
                  (index) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: gray100,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 2.0,
                    ),
                    margin: EdgeInsets.only(right: 4.0),
                    child: Text(
                      'first chip ',
                      style: TextStyle(fontSize: 12.0, color: gray700),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 4),
            if (isInGrid)
              Expanded(
                child: Text(
                  'content of notes ',
                  style: TextStyle(color: gray700),
                ),
              )
            else
              Text(
                'content of notes ',
                style: TextStyle(color: gray700),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            Row(
              children: [
                Text(
                  '04 ogest, 2025',

                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    color: gray500,
                  ),
                ),
                Spacer(),
                FaIcon(FontAwesomeIcons.trash, color: gray500, size: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
