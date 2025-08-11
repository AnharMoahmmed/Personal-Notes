
import 'package:flutter/material.dart';
import 'package:personal_notes/core/constans.dart';

class NoteFormField extends StatelessWidget {
  const NoteFormField({
    super.key,
      this.Controller,
    this.hintText,
    this.validator,
    this.onChanged,
    this.autofocus = false, this.filled ,
     
  });

  final TextEditingController? Controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool autofocus ; 
  final bool? filled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus,
      key: key,
      controller: Controller,

      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        isDense: true,
        filled: filled,
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
      validator: validator,
      onChanged: onChanged,
    );
  }
}
