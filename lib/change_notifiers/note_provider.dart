import 'package:flutter/material.dart';
import 'package:personal_notes/core/extension.dart';
import 'package:personal_notes/enums/order_options.dart';
import 'package:personal_notes/models/note.dart';
import 'package:personal_notes/services/auth_service.dart';

class NotesProvider extends ChangeNotifier {
  final List<Note> _notes = [];
  List<Note> get notes =>
      [..._searchTrem.isEmpty ? _notes : _notes.where(_test)]..sort(_compare);

  bool _test(Note note) {
    final term = _searchTrem.toLowerCase().trim();
    final title = note.title?.toLowerCase() ?? '';
    final content = note.content?.toLowerCase() ?? '';
    final tags = note.tags?.map((e) => e.toLowerCase()).toList() ?? [];
    return title.contains(term) ||
        content.contains(term) ||
        tags.deepContains(term);
    // (element) => element.title!.contains(_searchTrem);
  }

  int _compare(Note note1, note2) {
    return _OrederBy == OrederOptions.dateModified
        ? _isDescending
              ? note2.dateModified.compareTo(note1.dateModified)
              : note1.dateModified.compareTo(note2.dateModified)
        : _isDescending
        ? note2.dateModified.compareTo(note1.dateCreated)
        : note1.dateModified.compareTo(note2.dateCreated);
  }

  void addNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  void updateNote(Note note) {
    final index = _notes.indexWhere(
      (element) => element.dateCreated == note.dateCreated,
    );
    _notes[index] = note;
    notifyListeners();
  }

  void deleteNote(Note note) {
    _notes.remove(note);
    notifyListeners();
  }

  OrederOptions _OrederBy = OrederOptions.dateModified;
  set orderBy(OrederOptions value) {
    _OrederBy = value;
    notifyListeners();
  }

  OrederOptions get orderBy => _OrederBy;

  bool _isDescending = true;
  set isDescending(bool value) {
    _isDescending = value;
    notifyListeners();
  }

  bool get isDescending => _isDescending;

  bool _isGrid = true;
  set isGrid(bool value) {
    if (_isGrid == value) return; //fpt
    _isGrid = value;
    notifyListeners();
  }

  bool get isGrid => _isGrid;

  String _searchTrem = '';
  set searchTrem(String value) {
    _searchTrem = value;
    notifyListeners();
  }

  String get searchTerm => _searchTrem;

  void loadNotes() {
    // No action needed for a local-only list that starts empty.
  }
}
