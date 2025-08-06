import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  String get title => _title;
  String _content = '';

  set content(String value) {
    _content = value;
    notifyListeners();
  }

  String get content => _content;

  List<String> _tags = [];

  void addTags(String tag) {
    _tags.add(tag);
    notifyListeners();
  }

  List<String> get tags => _tags; 
}
  
  

//   //add chatgpt edit 
//  void toggleReadOnly() {
//     readOnly = !readOnly;
//     notifyListeners();
//   }
 


