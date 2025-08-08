import 'package:flutter/material.dart';
import 'package:personal_notes/change_notifiers/note_provider.dart';
import 'package:personal_notes/core/constans.dart';
import 'package:personal_notes/pages/main_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(context)=> NotesProvider() ,
      child: MaterialApp(
        title: 'personal notes 📒 ',
        theme: ThemeData(
          fontFamily: 'Poppins',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          appBarTheme: Theme.of(context).appBarTheme.copyWith(
            backgroundColor: Colors.transparent,
            titleTextStyle: const TextStyle(
              color: primary,
              fontSize: 32,
              fontFamily: 'Fredoka',
              // fontWeight: FontWeight.bold,
            ),
          ),
        ),
        home: const MainPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
