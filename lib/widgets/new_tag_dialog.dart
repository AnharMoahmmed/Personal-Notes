import 'package:flutter/material.dart';
import 'package:personal_notes/widgets/dialog_card.dart';
import 'package:personal_notes/widgets/note_button.dart';
 

class NewTagGialog extends StatefulWidget {
  const NewTagGialog({super.key, this.tag});

  final String? tag;

  @override
  State<NewTagGialog> createState() => _NewTagGialogState();
}

class _NewTagGialogState extends State<NewTagGialog> {
  late final TextEditingController tagController;
  late final GlobalKey<FormFieldState> tagKey;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    tagController = TextEditingController(text: widget.tag);
    tagKey = GlobalKey();
  }

  @override
  void dispose() {
    tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DialogCard(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'add tag',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 24),

            TextFormField(
              // Use TextFormField directly or fix NoteFormField
              controller: tagController, // lowercase 'controller'
              decoration: InputDecoration(
                hintText: 'Add tag (< 16 characters)',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return 'Should not be empty or only spaces';
                } else if (value.trim().length > 16) {
                  return 'Tag should not be more than 16 characters';
                }
                return null;
              },
              autofocus: true,
              onChanged: (newValue) {
                _formKey.currentState?.validate();
              },
            ),

            // NoteFormField(
            //   // key: _formKey,
            //   Controller: tagController,
            //   hintText: 'Add  tag (< 16 characters)',
            //   validator: (value) {
            //     if (value!.trim().isEmpty) {
            //       return 'should not be empty or only space ';
            //     } else if (value.trim().length > 16) {
            //       return 'tag should not be more than 16 characters';
            //     }
            //     return null;
            //   },
            //   onChanged: (newValue) {
            //     _formKey.currentState?.validate();
            //   },
            //   autofocus: true,
            // ),

            //AWS
            // NoteFormField(
            //   key: tagKey,
            //   Controller: tagController,
            //   hintText: 'Add tag (< 16 characters)',
            //   validator: (value) {
            //     if (value!.trim().isEmpty) {
            //       return 'No tags added';
            //     } else if (value.trim().length > 16) {
            //       return 'Tags should not be more than 16 characters';
            //     }
            //     return null;
            //   },
            //   onChanged: (newValue) {
            //     tagKey.currentState?.validate();
            //   },
            //   autofocus: true,
            // ),
            SizedBox(height: 24),

            // //me
            // NoteFormField(
            //   // key: tagKey,
            //   Controller: tagController,
            //   filled: true,
            //   hintText: 'Add tag (< 16 characters)',
            //   validator: (value) {
            //     if (value!.trim().isEmpty) {
            //       return 'no tages add';
            //     } else if (value.trim().length > 16) {
            //       return 'Tags should not be more than 16 characters';
            //     }
            //     return null;
            //   },
            //   onChanged: (newvalue) {
            //     tagKey.currentState?.validate();
            //   },
            // ),

            //AWS
            NoteButton(
              child: const Text('Add'),
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  Navigator.pop(context, tagController.text.trim());
                }
              },
            ),

            // NoteButton(
            //   child: Text('Add'),
            //   onPressed: () {
            //     if (tagKey.currentState?.validate() ?? false) {
            //       Navigator.pop(context, tagController.text.trim());
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
