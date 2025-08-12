import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:personal_notes/change_notifiers/note_provider.dart';
import 'package:personal_notes/change_notifiers/registration_controller.dart';
import 'package:personal_notes/core/constans.dart';
import 'package:personal_notes/firebase_options.dart';
import 'package:personal_notes/pages/main_page.dart';
import 'package:personal_notes/pages/registration_page.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NotesProvider()),
        ChangeNotifierProvider(create: (context) => RegistrationController()),
      ],
      child: MaterialApp(
        title: 'personal notes 📒 ',
        theme: ThemeData(
          fontFamily: 'Poppins',
          colorScheme: ColorScheme.fromSeed(seedColor: primary),
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
        home: const RegistrationPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
