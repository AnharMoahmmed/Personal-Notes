import 'package:flutter/material.dart';
// import 'package:flutter_quill/flutter_quill.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_notes/change_notifiers/new_note_controller.dart';
import 'package:personal_notes/core/constans.dart';
import 'package:personal_notes/widgets/dialog_card.dart';
import 'package:personal_notes/widgets/new_tag_dialog.dart';
import 'package:personal_notes/widgets/note_icon_button.dart';
import 'package:personal_notes/widgets/note_icon_button_outline.dart';
import 'package:personal_notes/widgets/note_tag.dart';
import 'package:provider/provider.dart';

class NewOrEidtNote extends StatefulWidget {
  const NewOrEidtNote({required this.isNewnNote, super.key});

  final bool isNewnNote;

  @override
  State<NewOrEidtNote> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<NewOrEidtNote> {
  late final NewNoteController newNoteController;
  late final FocusNode focusNode;

  //gpt
  // final NewNoteController = Provider.of<NewNoteController>(context, listen: false);

  // late final QuillController quillController;
  // final FocusNode focusNode = FocusNode();
  // final bool readOnly = false;

  @override
  void initState() {
    newNoteController = context.read<NewNoteController>();
    focusNode = FocusNode();
    super.initState();
    // quillController = QuillController.basic();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.isNewnNote) {
        focusNode.requestFocus();
        newNoteController.readOnly = false;
      } else {
        newNoteController.readOnly = true;
      }
    });
  }

  @override
  void dispose() {
    // quillController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isNewnNote ? 'New Note' : 'edit note'),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: NoteIconBottonOutline(
            OnPressed: () {},
            icon: FontAwesomeIcons.chevronLeft,
          ),
        ),
        actions: [
          Selector<NewNoteController, bool>(
            selector: (context, newNoteController) =>
                newNoteController.readOnly,
            builder: (context, readOnly, child) => NoteIconBottonOutline(
              icon: readOnly ? FontAwesomeIcons.pen : FontAwesomeIcons.bookOpen,
              OnPressed: () {
                newNoteController.readOnly = !readOnly;

                if (newNoteController.readOnly) {
                  FocusScope.of(context).unfocus();
                  focusNode.unfocus();
                } else {
                  focusNode.requestFocus();
                }
              },
            ),
          ),

          NoteIconBottonOutline(
            OnPressed: () {
              newNoteController.saveNote(context);
              Navigator.pop(context);
            },
            icon: FontAwesomeIcons.check,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Selector<NewNoteController, bool>(
              selector: (context, controller) => controller.readOnly,
              builder: (context, readOnly, child) => TextField(
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  hintText: 'Title here',
                  hintStyle: TextStyle(color: gray300),
                  border: InputBorder.none,
                ),
                canRequestFocus: !readOnly,
                onChanged: (newvalue) {
                  newNoteController.title = newvalue;
                },
              ),
            ),
            if (!widget.isNewnNote) ...[
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      'last modified',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: gray500,
                      ),
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
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: gray500,
                      ),
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
                            builder: (context) =>
                                DialogCard(child: NewTagGialog()),
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(color: gray500, thickness: 2),
            ),
            Expanded(
              child: Selector<NewNoteController, bool>(
                selector: (_, controller) => controller.readOnly,
                builder: (_, readOnly, __) => Column(
                  children: [
                    TextField(
                      style: TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        hintText: 'Type here..',
                        hintStyle: TextStyle(color: gray300),
                        border: InputBorder.none,
                      ),
                      readOnly: readOnly,
                      focusNode: focusNode,

                      //   child: QuillEditor(
                      //     controller: quillController,
                      //     scrollController: ScrollController(),

                      //     focusNode: focusNode,
                      //   ),
                      onChanged: (newValue) {
                        newNoteController.content = newValue;
                      },
                    ),
                    // QuillToolbar(controller: quillController),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
