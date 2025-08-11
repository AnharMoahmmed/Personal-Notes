import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_notes/core/constans.dart';
import 'package:personal_notes/widgets/note_button.dart';
import 'package:personal_notes/widgets/note_form_field.dart';
import 'package:personal_notes/widgets/note_icon_button.dart';
import 'package:personal_notes/widgets/note_icon_button_outline.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Register',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 45,
                    fontFamily: 'Fredoka',
                    fontWeight: FontWeight.w600,
                    color: primary,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'In order to save your notes on cloud,  you have to register / sign in to app',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.0),
                NoteFormField(hintText: 'Full Name', filled: false),
                SizedBox(height: 8.0),
                NoteFormField(hintText: 'Email adress'),
                SizedBox(height: 8.0),
                NoteFormField(hintText: 'Password '),
                SizedBox(height: 8.0),

                NoteButton(lable: 'Create my account', onPressed: () {}),

                SizedBox(height: 32.0),
                Row(
                  children: [
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('or register with'),
                    ),
                    Divider(),
                  ],
                ),
                SizedBox(height: 32.0),
                Row(
                  children: [
                    NoteIconBottonOutline(
                      icon: FontAwesomeIcons.google,
                      OnPressed: () {},
                    ),
                    SizedBox(width: 16.0),

                    NoteIconBottonOutline(
                      icon: FontAwesomeIcons.facebook,
                      OnPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: 32.0),

                Text.rich(
                  TextSpan(
                    text: 'Already have an  acount?',
                    children: [TextSpan(text: 'Sign in ')],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
