import 'package:flutter/material.dart';
import 'package:personal_notes/core/constans.dart';

class NoteTag extends StatelessWidget {
  const NoteTag({super.key, required this.lable, this.onClosed});

  final String lable;

  final VoidCallback? onClosed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: gray100,
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
      margin: EdgeInsets.only(right: 4.0),
      child: Row(
        children: [
          Text(
            lable,
            style: TextStyle(
              fontSize: onClosed != null ? 14.0 : 12.0,
              color: gray700,
            ),
          ),
          if (onClosed != null) ...{
            SizedBox(width: 4.0),
            GestureDetector(onTap: onClosed, child: Icon(Icons.close)),
          },
        ],
      ),
    );
  }
}
