import 'package:flutter/material.dart';
import 'package:personal_notes/core/constans.dart';
import 'package:personal_notes/widgets/dialog_card.dart';
import 'package:personal_notes/widgets/note_button.dart';
import 'package:personal_notes/widgets/note_form_field.dart';

class NewTagGialog extends StatefulWidget {
  const NewTagGialog({super.key, this.tag});

  final String? tag;

  @override
  State<NewTagGialog> createState() => _NewTagGialogState();
}

class _NewTagGialogState extends State<NewTagGialog> {
  late final TextEditingController tagController;
  late final GlobalKey<FormFieldState> tagKey;

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
          NoteFormField(
            key: tagKey,
            Controller: tagController,
            hintText: 'Add  tag (< 16 characters)',
            validator: (value) {
              if (value!.trim().isEmpty) {
                return 'should not be empty or only space ';
              } else if (value.trim().length > 16) {
                return 'tag should not be more than 16 characters';
              }
              return null;
            },
            onChanged: (newValue) {
              tagKey.currentState?.validate();
            },
             autofocus:  true,
          ),
          SizedBox(height: 24),
      
          NoteButton(
            lable: 'Add',
            onPressed: () {
              if (tagKey.currentState?.validate() ?? false) {
                Navigator.pop(context, tagController.text.trim());
              }
            },
          ),
        ],
      ),
    );
  }
}
