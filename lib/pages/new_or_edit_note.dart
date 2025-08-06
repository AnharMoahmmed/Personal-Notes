import 'package:flutter/material.dart';
// import 'package:flutter_quill/flutter_quill.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_notes/change_notifiers/new_note_controller.dart';
import 'package:personal_notes/core/constans.dart';
import 'package:personal_notes/widgets/note_icon_button.dart';
import 'package:personal_notes/widgets/note_icon_button_outline.dart';
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

          NoteIconBottonOutline(OnPressed: () {}, icon: FontAwesomeIcons.check),
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
                      NoteIconButton(
                        icon: FontAwesomeIcons.circlePlus,
                        OnPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => Center(
                              child: Material(
                                child: Container(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.75,
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        'add tag',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      TextField(
                                        decoration: InputDecoration(
                                          hintText: 'add tag(< 16 characters)',
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            borderSide: BorderSide(
                                              color: primary,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            borderSide: BorderSide(
                                              color: primary,
                                            ),
                                          ),
                                        ),
                                      ),

                                      ElevatedButton(
                                        onPressed: () {},
                                        child: Text('add tag'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: primary,
                                          foregroundColor: Colors.white,
                                          side: BorderSide(color: Colors.black),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Text(
                    'no tags added',
                    style: TextStyle(fontWeight: FontWeight.bold),
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
