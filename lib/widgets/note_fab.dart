import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_notes/core/constans.dart';

class NoteFab extends StatelessWidget {
  const NoteFab({
    required this.onPressed
    ,super.key});

final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 195, 191, 191),
            offset: Offset(4, 4),
          ),
        ],
      ),
      child: FloatingActionButton(
        onPressed: onPressed,

        backgroundColor: primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16),
          side: BorderSide(color: Colors.white),
        ),
        child: FaIcon(FontAwesomeIcons.plus),
      ),
    );
  }
}
