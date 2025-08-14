import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:personal_notes/change_notifiers/note_provider.dart';
import 'package:personal_notes/change_notifiers/registration_controller.dart';
import 'package:personal_notes/core/constans.dart';
import 'package:personal_notes/firebase_options.dart';
import 'package:personal_notes/pages/main_page.dart';
import 'package:personal_notes/pages/registration_page.dart';
import 'package:personal_notes/services/auth_service.dart';
import 'package:personal_notes/services/notification_service,dart';
import 'package:provider/provider.dart';
  
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart';
 
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().requestPermissions();

   await NotificationService().init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
   runApp(MyApp(navigatorKey: navigatorKey));

  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  const MyApp({super.key, required this.navigatorKey});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NotesProvider()),
        ChangeNotifierProvider(create: (context) => RegistrationController()),
          ChangeNotifierProvider(
          create: (context) => NotesProvider()..loadNotes(),
        ),
        ChangeNotifierProvider(create: (context) => RegistrationController()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
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
        home: StreamBuilder<User?>(
          stream: AuthService.userStream,
          builder: (context, snapshot) {
            return snapshot
                    .hasData //&& AuthService.isEmailVerfied
                ? const MainPage()
                : RegistrationPage();
          },
        ),

        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
