
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_notes/core/constans.dart';

class NoteIconBottonOutline extends StatelessWidget {
  const NoteIconBottonOutline({
    required this.OnPressed, 
    required this.icon
    ,
    super.key});
  final IconData icon;
  final VoidCallback? OnPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: OnPressed,
      icon: FaIcon(icon),
      style: IconButton.styleFrom(
        backgroundColor: primary,
        // foregroundColor: white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(12),

          side: BorderSide(color: Colors.black26),
        ),
      ),
    );
  }
}
