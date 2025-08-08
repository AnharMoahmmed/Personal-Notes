import 'package:flutter/material.dart';
import 'package:personal_notes/core/constans.dart';

class NewTagGialog extends StatefulWidget {
  const NewTagGialog({super.key});

  @override
  State<NewTagGialog> createState() => _NewTagGialogState();
}

class _NewTagGialogState extends State<NewTagGialog> {
  late final TextEditingController tagController;
  late final GlobalKey<FormFieldState> tagKey;

  @override
  void initState() {
    super.initState();
    tagController = TextEditingController();
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
              return 'no tage added';
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

        DecoratedBox(
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(offset: Offset(2, 2), color: Colors.black)],
            borderRadius: BorderRadius.circular(8),
          ),

          child: ElevatedButton(
            onPressed: () {
              if (tagKey.currentState?.validate() ?? false) {
                Navigator.pop(context, tagController.text.trim());
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primary,
              foregroundColor: Colors.white,
              side: BorderSide(color: Colors.black),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text('Add '),
          ),
        ),
      ],
    );
  }
}
