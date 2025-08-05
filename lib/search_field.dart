import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_notes/core/constans.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search notes...',
        hintStyle: TextStyle(fontSize: 12),
        prefixIcon: Icon(FontAwesomeIcons.magnifyingGlass),
        fillColor: Colors.white,
        filled: true,
        isDense: true,
        prefixIconConstraints: BoxConstraints(minHeight: 42, minWidth: 42),
        contentPadding: EdgeInsets.zero,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primary),
        ),
      ),
    );
  }
}
