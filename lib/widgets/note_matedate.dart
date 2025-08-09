import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_notes/change_notifiers/new_note_controller.dart';
import 'package:personal_notes/core/constans.dart';
import 'package:personal_notes/widgets/dialog_card.dart';
import 'package:personal_notes/widgets/new_tag_dialog.dart';
import 'package:personal_notes/widgets/note_icon_button.dart';
import 'package:personal_notes/widgets/note_tag.dart';
import 'package:provider/provider.dart';

class NoteMatedate extends StatefulWidget {
  const NoteMatedate({super.key, required this.isNewnNote});
  final bool isNewnNote;

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
        if (!widget.isNewnNote) ...[
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
                  '08 Aug 2025 , 12:08 PM',
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
                  '08 Aug 2025 , 12:08 PM',
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
                      final String? tag = await showDialog<String?>(
                        context: context,
                        builder: (context) => DialogCard(child: NewTagGialog()),
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
