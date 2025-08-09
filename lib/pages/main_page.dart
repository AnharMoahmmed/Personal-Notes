import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_notes/change_notifiers/new_note_controller.dart';
import 'package:personal_notes/change_notifiers/note_provider.dart';
import 'package:personal_notes/core/constans.dart';
import 'package:personal_notes/models/note.dart';
import 'package:personal_notes/pages/new_or_edit_note.dart';
import 'package:personal_notes/widgets/no_notes.dart';
import 'package:personal_notes/widgets/note_grid.dart';

import 'package:personal_notes/widgets/note_fab.dart';
import 'package:personal_notes/widgets/note_icon_button_outline.dart';
import 'package:personal_notes/widgets/note_list.dart';
import 'package:personal_notes/search_field.dart';
import 'package:personal_notes/widgets/view_options.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

 
class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text('Personal Notes📒'),
        actions: [
          NoteIconBottonOutline(
            icon: FontAwesomeIcons.rightFromBracket,
            OnPressed: () {},
          ),
        ],
      ),
      floatingActionButton: NoteFab(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(create: (context) => NewNoteController(), child: NewOrEidtNote(isNewnNote: true)),
            ),
          );
        },
      ),
      body: Consumer<NotesProvider>(
        builder: (context, notesProvider, child) {
          final List<Note> notes = notesProvider.notes;
          return notes.isEmpty
              ? NoNotes()
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SearchField(),
                      ViewOptions()
                           ,

                      Expanded(
                        child: notesProvider.isGrid
                            ? notesGrid(notes: notes)
                            : NotesList(notes: notes),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}

