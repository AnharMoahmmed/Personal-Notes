import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_notes/change_notifiers/new_note_controller.dart';
import 'package:personal_notes/core/constans.dart';
import 'package:personal_notes/core/dialogs.dart';
import 'package:personal_notes/core/utils.dart';
import 'package:personal_notes/models/note.dart';
import 'package:personal_notes/widgets/dialog_card.dart';
import 'package:personal_notes/widgets/new_tag_dialog.dart';
import 'package:personal_notes/widgets/note_icon_button.dart';
import 'package:personal_notes/widgets/note_tag.dart';
import 'package:provider/provider.dart';

class NoteMatedate extends StatefulWidget {
  const NoteMatedate({super.key, required this.note});
  // final bool isNewnNote;    // it is automatically a new note so no need fo this line
  final Note? note;

  @override
  State<NoteMatedate> createState() => _NoteMatedateState();
}

class _NoteMatedateState extends State<NoteMatedate> {
  late final NewNoteController newNoteController;

  @override
  void initState() {
    super.initState();
    newNoteController = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.note != null) ...[
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'last modified',
                  style: TextStyle(fontWeight: FontWeight.bold, color: gray500),
                ),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  toLongDate(widget.note!.dateModified),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'created',
                  style: TextStyle(fontWeight: FontWeight.bold, color: gray500),
                ),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  toLongDate(widget.note!.dateCreated),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Text('tags'),
                  SizedBox(width: 4),
                  NoteIconButton(
                    icon: FontAwesomeIcons.circlePlus,
                    OnPressed: () async {
                      final String? tag = await ShowNewTagDialog(
                        context: context,
                      );
                      if (tag != null) {
                        newNoteController.addTags(tag);
                      }
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Selector<NewNoteController, List<String>>(
                selector: (_, newNoteController) => newNoteController.tags,
                builder: (_, tags, _) => tags.isEmpty
                    ? Text(
                        'no tags added',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            tags.length,
                            (index) => NoteTag(
                              lable: tags[index],
                              onClosed: () {
                                newNoteController.removeTag((index));
                              },
                              onTap: () async {
                                final String? tag = await ShowNewTagDialog(
                                  context: context,
                                  tag: tags[index],
                                );

                                if (tag != null && tag != tag[index]) {
                                  newNoteController.updateTag(tag, index);
                                }
                              },
                            ),
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
