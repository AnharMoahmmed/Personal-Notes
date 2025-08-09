import 'package:flutter/material.dart';
import 'package:personal_notes/core/constans.dart';
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
    return Column(
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
          autofocus: true,
          key: tagKey,
          controller: tagController,

          decoration: InputDecoration(
            hintText: 'add tag(< 16 characters)',
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            isDense: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: primary),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: primary),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
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
    );
  }
}
