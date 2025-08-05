import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_notes/core/constans.dart';
import 'package:personal_notes/widgets/not_grid.dart';
import 'package:personal_notes/widgets/note_card.dart';
import 'package:personal_notes/widgets/note_fab.dart';
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
          IconButton(
            onPressed: () {},
            icon: FaIcon(FontAwesomeIcons.person),
            style: IconButton.styleFrom(
              backgroundColor: primary,
              // foregroundColor: white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(12),

                side: BorderSide(color: Colors.black26),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: NoteFab(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchField(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isDescending = !isDescending;
                      });
                    },
                    icon: FaIcon(
                      isDescending
                          ? FontAwesomeIcons.arrowDown
                          : FontAwesomeIcons.arrowUp,
                    ),
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    constraints: BoxConstraints(),
                    style: IconButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    iconSize: 18,
                    color: const Color.fromARGB(255, 73, 71, 71),
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
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isGrid = !isGrid;
                      });
                    },
                    icon: FaIcon(
                      isGrid
                          ? FontAwesomeIcons.tableCellsLarge
                          : FontAwesomeIcons.bars,
                    ),
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    constraints: BoxConstraints(),
                    style: IconButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    iconSize: 18,
                    color: const Color.fromARGB(255, 73, 71, 71),
                  ),
                ],
              ),
            ),

            Expanded(child: isGrid ? notsGrid() : NotesList()),
          ],
        ),
      ),
    );
  }
}
