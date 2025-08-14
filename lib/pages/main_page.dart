import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_notes/change_notifiers/new_note_controller.dart';
import 'package:personal_notes/change_notifiers/note_provider.dart';
import 'package:personal_notes/core/constans.dart';
import 'package:personal_notes/core/dialogs.dart';
import 'package:personal_notes/models/note.dart';
import 'package:personal_notes/pages/new_or_edit_note.dart';
import 'package:personal_notes/services/auth_service.dart';
import 'package:personal_notes/widgets/no_notes.dart';
import 'package:personal_notes/widgets/note_grid.dart';
import 'package:personal_notes/widgets/note_fab.dart';
import 'package:personal_notes/widgets/note_icon_button_outline.dart';
import 'package:personal_notes/widgets/note_list.dart';
import 'package:personal_notes/search_field.dart';
import 'package:personal_notes/widgets/view_options.dart';
import 'package:provider/provider.dart';
import 'package:timezone/browser.dart';
import 'package:timezone/data/latest.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  ///initestate for local notification
  @override
  void initState() {
    // init();
     Future.microtask(() => init());
    // TODO: implement initState
    super.initState();
  }

  Future<void> init() async {
    initializeTimeZones();
    //! https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
    setLocalLocation(getLocation('Asia/Aden'));
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/launcher_icon',
    );
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text('Personal Notes📒'),
        actions: [
          NoteIconBottonOutline(
            icon: FontAwesomeIcons.rightFromBracket,
            OnPressed: () async {
              final bool shouldLogout =
                  await ShowConfirmationDialog(context: context) ?? false;

              if (shouldLogout) {
                AuthService.logout();
              }
            },
          ),
        ],
      ),
      floatingActionButton: NoteFab(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                create: (context) => NewNoteController(),
                child: NewOrEidtNote(isNewnNote: true),
              ),
            ),
          );
        },
      ),
      body: Consumer<NotesProvider>(
        builder: (context, notesProvider, child) {
          final List<Note> notes = notesProvider.notes;
          return notes.isEmpty && notesProvider.searchTerm.isEmpty
              ? NoNotes()
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SearchField(),
                      if (notes.isNotEmpty) ...[
                        ViewOptions(),

                        Expanded(
                          child: notesProvider.isGrid
                              ? notesGrid(notes: notes)
                              : NotesList(notes: notes),
                        ),
                      ] else
                        Expanded(
                          child: Center(
                            child: Text(
                              'no notes found for your search "${notesProvider.searchTerm}"',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
