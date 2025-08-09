import 'package:flutter/material.dart';
import 'package:personal_notes/change_notifiers/note_provider.dart';
import 'package:personal_notes/models/note.dart';
import 'package:provider/provider.dart';

class NewNoteController extends ChangeNotifier {
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
  bool get CanSaveNote {
      final String? newTitle = title.isNotEmpty ? title : null;
    final String? newContent = content.isNotEmpty ? content : null;
    return newTitle != null  || newContent != null ;
  }
  void saveNote(BuildContext context) {
    final String? newTitle = title.isNotEmpty ? title : null;
    final String? newContent = content.isNotEmpty ? content : null;
    final now = DateTime.now().microsecondsSinceEpoch;
    final Note note = Note(
      title:newTitle, 
      content: newContent,
      dateCreated: now,
      dateModified: now,
      tags: tags, 
    );

    context.read<NotesProvider>().addNote(note);
  }
}
  
  

//   //add chatgpt edit 
//  void toggleReadOnly() {
//     readOnly = !readOnly;
//     notifyListeners();
//   }
 


