import 'package:flutter/material.dart';
// import 'package:flutter_quill/flutter_quill.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_notes/core/constans.dart';
import 'package:personal_notes/widgets/note_icon_button.dart';
import 'package:personal_notes/widgets/note_icon_button_outline.dart';

class NewOrEidtNote extends StatefulWidget {
  const NewOrEidtNote({required this.isNewnNote, super.key});

  final bool isNewnNote;

  @override
  State<NewOrEidtNote> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<NewOrEidtNote> {
  late final FocusNode focusNode;

  late bool readOnly;
  // late final QuillController quillController;
  // final FocusNode focusNode = FocusNode();
  // final bool readOnly = false;

  @override
  void initState() {
    focusNode = FocusNode();
    super.initState();
    // quillController = QuillController.basic();
    if (widget.isNewnNote) {
      focusNode.requestFocus();
      readOnly = false;
    } else {
      readOnly = true;
    }
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
          NoteIconBottonOutline(
            OnPressed: () {
              setState(() {
                readOnly = !readOnly;

                if (readOnly) {
                  FocusScope.of(context).unfocus();
                  focusNode.unfocus();
                } else {
                  focusNode.requestFocus();
                }
              });
            },
            icon: readOnly ? FontAwesomeIcons.pen : FontAwesomeIcons.bookOpen,
          ),
          NoteIconBottonOutline(OnPressed: () {}, icon: FontAwesomeIcons.check),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                hintText: 'Title here',
                hintStyle: TextStyle(color: gray300),
                border: InputBorder.none,
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
                      Text('taged'),
                      NoteIconButton(
                        icon: FontAwesomeIcons.circlePlus,
                        OnPressed: () {},
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
              child: Column(
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
                  ),
                  // QuillToolbar(controller: quillController),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
