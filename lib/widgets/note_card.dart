import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:personal_notes/change_notifiers/new_note_controller.dart';
import 'package:personal_notes/change_notifiers/note_provider.dart';
import 'package:personal_notes/core/constans.dart';
import 'package:personal_notes/core/dialogs.dart';
import 'package:personal_notes/core/utils.dart';
import 'package:personal_notes/models/note.dart';
import 'package:personal_notes/pages/new_or_edit_note.dart';
import 'package:personal_notes/widgets/note_tag.dart';
import 'package:provider/provider.dart';

class NoteCard extends StatelessWidget {
  NoteCard({required this.isInGrid, required this.note, super.key});
  bool isInGrid = true;
  final Note note;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (_) => NewNoteController()
                ..note =
                    note, // use the cascadt to assigine note to open the same note u preesed in newOrEidtNote
              child: NewOrEidtNote(isNewnNote: false),
            ),
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
            if (note.title != null) ...[
              Text(
                note.title!,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: gray900,
                ),
              ),
              SizedBox(height: 4),
            ],
            if (note.tags != null) ...[
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    note.tags!.length,
                    (index) => NoteTag(lable: note.tags![index]),
                  ),
                ),
              ),
              SizedBox(height: 4),
            ],
            if (note.content != null) ...[
              if (isInGrid)
                Expanded(
                  child: Text(
                    note.content!,
                    // note.content!, in case the content be empty use this insted of   note.content,
                    style: TextStyle(color: gray700),
                  ),
                )
              else
                Text(
                  note.content!,
                  style: TextStyle(color: gray700),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
            Spacer(),
            Row(
              children: [
                Text(
                  toShortDate(note.dateModified),

                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    color: gray500,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () async {
                    final shouldDelete =
                        await ShowConfirmationDialog(context: context, ) ?? false;
                    if(shouldDelete && context.mounted) {
                      context.read<NotesProvider>().deleteNote(note);
                    }
                  },
                  child: FaIcon(
                    FontAwesomeIcons.trash,
                    color: gray500,
                    size: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
