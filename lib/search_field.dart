import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_notes/change_notifiers/note_provider.dart';
import 'package:personal_notes/core/constans.dart';
import 'package:provider/provider.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late final TextEditingController searchController;
  late final NotesProvider notesProvider;

  @override
  void initState() {
    super.initState();
    notesProvider = context.read();
    searchController = TextEditingController()
      ..addListener(() {
        notesProvider.searchTrem = searchController.text;
      });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        hintText: 'Search notes...',
        hintStyle: TextStyle(fontSize: 12),
        prefixIcon: Icon(FontAwesomeIcons.magnifyingGlass, size: 16),
        suffixIcon: ListenableBuilder(
          listenable: searchController,
          builder: (context, clearButon) =>
              searchController.text.isNotEmpty ? clearButon! : SizedBox.shrink(),
          child: GestureDetector(
            onTap: () {
              //  notesProvider.searchTrem = ''; // use the  searchController  insted of that 
              searchController.clear();
            },
            child: Icon(FontAwesomeIcons.circleXmark),
          ),
        ),

        fillColor: Colors.white,
        filled: true,
        isDense: true,
        prefixIconConstraints: BoxConstraints(minHeight: 42, minWidth: 42),
        suffixIconConstraints: BoxConstraints(minHeight: 42, minWidth: 42),
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
