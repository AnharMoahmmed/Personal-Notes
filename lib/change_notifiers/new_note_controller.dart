import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:personal_notes/change_notifiers/note_provider.dart';
import 'package:personal_notes/models/note.dart';
import 'package:provider/provider.dart';

class NewNoteController extends ChangeNotifier {
  Note? _note;

  set note(Note? value) {
    _note = value;
    _title = _note!.title ?? '';
    _content = _note!.content ?? '';
    _tags.addAll(_note!.tags ?? []);

    notifyListeners();
  }

  Note? get note => _note;

  bool _readOnly = false;
  //wrong set
  // set readOnly(bool value) {
  //   readOnly = _readOnly;

  //   notifyListeners();
  // }

  bool get readOnly => _readOnly;

  set readOnly(bool value) {
    if (_readOnly == value) return;
    _readOnly = value;
    notifyListeners();
  }

  String _title = '';
  set title(String value) {
    _title = value;
    notifyListeners();
  }

  String get title => _title.trim();
  String _content = '';

  set content(String value) {
    _content = value;
    notifyListeners();
  }

  String get content => _content.trim();

  List<String> _tags = [];

  void addTags(String tag) {
    _tags.add(tag);
    notifyListeners();
  }

  List<String> get tags => [..._tags];

  void removeTag(int index) {
    _tags.removeAt(index);
    notifyListeners();
  }

  void updateTag(String tag, int index) {
    _tags[index] = tag;
    notifyListeners();
  }

  bool get isNewNote => _note == null;
  bool get CanSaveNote {
    final String? newTitle = title.isNotEmpty ? title : null;
    final String? newContent = content.isNotEmpty ? content : null;
    bool canSave = newTitle != null || newContent != null;

    if (!isNewNote) {
      canSave &=
          newTitle != _note!.title ||
          newContent != _note!.content ||
          !listEquals(tags, _note!.tags);
    }
    //   if (isNewNote) {
    //     return canSave;
    //   } else {
    //     return ((newTitle != _note!.title ||
    //             newContent != _note!.content ||
    //             !listEquals(tags, _note!.tags)) &&
    //         (newTitle != null || newContent != null));
    //   } // no need for this we will use the canSave only it is the same of this

    return canSave;
  }

  void saveNote(BuildContext context) {
    final String? newTitle = title.isNotEmpty ? title : null;
    final String? newContent = content.isNotEmpty ? content : null;
    final now = DateTime.now().microsecondsSinceEpoch;
    final Note note = Note(
      title: newTitle,
      content: newContent,
      dateCreated: isNewNote ? now : _note!.dateCreated,
      dateModified: now,
      tags: tags,
    );

    final notesProvider = context.read<NotesProvider>();

    isNewNote ? notesProvider.addNote(note) : notesProvider.updateNote(note);
  }
}
  
  

//   //add chatgpt edit 
//  void toggleReadOnly() {
//     readOnly = !readOnly;
//     notifyListeners();
//   }
 


