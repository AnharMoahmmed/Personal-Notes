import 'package:flutter/material.dart';
import 'package:personal_notes/core/constans.dart';

class NoteButton extends StatelessWidget {
  const NoteButton({
    super.key,
    required this.lable,
    this.onPressed,
    this.isOutLine = false,
  });

  final String lable;
  final VoidCallback? onPressed;
  final bool isOutLine;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(2, 2),
            color: isOutLine ? primary : Colors.black,
          ),
        ],
        borderRadius: BorderRadius.circular(8),
      ),

      child: ElevatedButton(
        onPressed: onPressed,
        //  () {
        //   // if (tagKey.currentState?.validate() ?? false) {
        //   //   Navigator.pop(context, tagController.text.trim());
        //   // }
        // }
        style: ElevatedButton.styleFrom(
          backgroundColor:  isOutLine ? Colors.white : primary ,
          foregroundColor:isOutLine ? primary : Colors.white,
          side: BorderSide(color:isOutLine ? primary : Colors.black),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(lable),
      ),
    );
  }
}
