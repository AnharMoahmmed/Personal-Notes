import 'package:flutter/material.dart';
// import 'package:flutter_quill/flutter_quill.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_notes/change_notifiers/new_note_controller.dart';
import 'package:personal_notes/core/constans.dart';
import 'package:personal_notes/core/dialogs.dart';
import 'package:personal_notes/widgets/note_icon_button_outline.dart';
import 'package:personal_notes/widgets/note_matedate.dart';
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
  late final TextEditingController titelController;
  late final TextEditingController ContentController;

  //gpt
  // final NewNoteController = Provider.of<NewNoteController>(context, listen: false);

  // late final QuillController quillController;
  // final FocusNode focusNode = FocusNode();
  // final bool readOnly = false;

  @override
  void initState() {
    newNoteController = context.read<NewNoteController>();
    focusNode = FocusNode();
    titelController = TextEditingController(text: newNoteController.title);
    ContentController = TextEditingController(text: newNoteController.content);
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
    titelController.dispose();
    ContentController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return; //do nothing in this case
        if (!newNoteController.CanSaveNote) {
          Navigator.pop(context);
          return; //this whene check ✔️  and there is nothig written ..> to not show dialog
        }
        final bool? shouldSave = await ShowConfirmationDialog(context: context);

        if (shouldSave == null) return;
        if (!context.mounted) return;
        if (shouldSave) {
          newNoteController.saveNote(context);
        }
        Navigator.pop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.isNewnNote ? 'New Note' : 'edit note'),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: NoteIconBottonOutline(
              OnPressed: () {
                Navigator.maybePop(context);
              },
              icon: FontAwesomeIcons.chevronLeft,
            ),
          ),
          actions: [
            Selector<NewNoteController, bool>(
              selector: (context, newNoteController) =>
                  newNoteController.readOnly,
              builder: (context, readOnly, child) => NoteIconBottonOutline(
                icon: readOnly
                    ? FontAwesomeIcons.pen
                    : FontAwesomeIcons.bookOpen,
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

            Selector<NewNoteController, bool>(
              selector: (_, NewNoteController) => newNoteController.CanSaveNote,
              builder: (_, CanSaveNote, _) => NoteIconBottonOutline(
                OnPressed: CanSaveNote
                    ? () {
                        newNoteController.saveNote(context);
                        Navigator.pop(context);
                      }
                    : null,
                icon: FontAwesomeIcons.check,
              ),
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
                  controller: titelController,
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
              NoteMatedate(note: newNoteController.note),
              Expanded(
                child: Selector<NewNoteController, bool>(
                  selector: (_, controller) => controller.readOnly,
                  builder: (_, readOnly, __) => Column(
                    children: [
                      TextField(
                        controller: ContentController,
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
      ),
    );
  }
}
