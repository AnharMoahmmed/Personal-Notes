import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_notes/core/constans.dart';

class NoteIconButton extends StatelessWidget {
  const NoteIconButton({
    required this.icon,
    required this.OnPressed,
      this.sized,
    super.key,
  });
  final IconData icon;
  final double? sized;
  final VoidCallback? OnPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: OnPressed,
      icon: FaIcon(icon),
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      constraints: BoxConstraints(),
      style: IconButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      iconSize: sized,
      color: gray700,
    );
  }
}
   
// setState(() {
//                         isDescending = !isDescending;
//                       });


//  isDescending
//                           ? FontAwesomeIcons.arrowDown
//                           : FontAwesomeIcons.arrowUp,