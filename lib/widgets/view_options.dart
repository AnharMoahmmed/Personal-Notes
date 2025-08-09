import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_notes/change_notifiers/note_provider.dart';
import 'package:personal_notes/enums/order_options.dart';
import 'package:personal_notes/pages/main_page.dart';
import 'package:personal_notes/widgets/note_icon_button.dart';
import 'package:provider/provider.dart';

class ViewOptions extends StatefulWidget {
  const ViewOptions({super.key});

  @override
  State<ViewOptions> createState() => _ViewOptionsState();
}

class _ViewOptionsState extends State<ViewOptions> {
   
  @override
  Widget build(BuildContext context) {
    return Consumer<NotesProvider>(
      builder: (_, notesProvider, __) =>
        Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            NoteIconButton(
              OnPressed: () {
                setState(() {
                 notesProvider.isDescending = !notesProvider.isDescending;
                });
              },
              icon: notesProvider.isDescending
                  ? FontAwesomeIcons.arrowDown
                  : FontAwesomeIcons.arrowUp,
              sized: 18,
            ),
      
            SizedBox(width: 16),
            DropdownButton<OrederOptions>(
              value: notesProvider.orderBy,
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
              items: OrederOptions.values
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Row(
                        children: [
                          Text(e.name),
                          if (e == notesProvider.orderBy) ...[
                            SizedBox(width: 8.0),
                            Icon(Icons.check),
                          ],
                        ],
                      ),
                    ),
                  )
                  .toList(),
              selectedItemBuilder: (context) =>
                  OrederOptions.values.map((e) => Text(e.name)).toList(),
              onChanged: (newValue) {
                setState(() {
                 notesProvider.orderBy  = newValue!;
                });
              },
            ),
            Spacer(),
            NoteIconButton(
              OnPressed: () {
                setState(() {
                  notesProvider.isGrid = !notesProvider.isGrid;
                });
              },
              icon: notesProvider.isGrid
                  ? FontAwesomeIcons.tableCellsLarge
                  : FontAwesomeIcons.bars,
      
              sized: 18,
            ),
          ],
        ),
      ),
    );
  }
}
