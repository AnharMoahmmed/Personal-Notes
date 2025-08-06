import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_notes/core/constans.dart';
import 'package:personal_notes/pages/new_or_edit_note.dart';
import 'package:personal_notes/widgets/note_grid.dart';

import 'package:personal_notes/widgets/note_fab.dart';
import 'package:personal_notes/widgets/note_icon_button.dart';
import 'package:personal_notes/widgets/note_icon_button_outline.dart';
import 'package:personal_notes/widgets/note_list.dart';
import 'package:personal_notes/search_field.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

final List<String> dropDowenOptions = ['Date Modfied', 'Date change'];
late String dropDowenValue = dropDowenOptions.first;

bool isDescending = true;

bool isGrid = true;

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
            MaterialPageRoute(builder: (context) => NewOrEidtNote(isNewnNote: true)),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchField(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  NoteIconButton(
                    OnPressed: () {
                      setState(() {
                        isDescending = !isDescending;
                      });
                    },
                    icon: isDescending
                        ? FontAwesomeIcons.arrowDown
                        : FontAwesomeIcons.arrowUp,
                        sized: 18,
                  ),

                  SizedBox(width: 16),
                  DropdownButton(
                    value: dropDowenValue,
                    icon: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: FaIcon(
                        FontAwesomeIcons.arrowDownWideShort,
                        size: 18,
                        color: Colors.blueGrey,
                      ),
                    ),
                    underline: SizedBox.shrink(),
                    borderRadius: BorderRadius.circular(16.0),
                    isDense: true,
                    items: dropDowenOptions
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Row(
                              children: [
                                Text(e),
                                if (e == dropDowenValue) ...[
                                  SizedBox(width: 8.0),
                                  Icon(Icons.check),
                                ],
                              ],
                            ),
                          ),
                        )
                        .toList(),
                    selectedItemBuilder: (context) =>
                        dropDowenOptions.map((e) => Text(e)).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        dropDowenValue = newValue!;
                      });
                    },
                  ),
                  Spacer(),
                  NoteIconButton(
                    OnPressed: () {
                      setState(() {
                        isGrid = !isGrid;
                      });
                    },
                    icon: isGrid
                        ? FontAwesomeIcons.tableCellsLarge
                        : FontAwesomeIcons.bars,

                        sized: 18,
                  ),
                ],
              ),
            ),

            Expanded(child: isGrid ? notesGrid() : NotesList()),
          ],
        ),
      ),
    );
  }
}
