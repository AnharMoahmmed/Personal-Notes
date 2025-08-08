import 'package:flutter/material.dart';

class NoNotes extends StatelessWidget {
  const NoNotes({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/person.png',
              width: MediaQuery.sizeOf(context).width * 0.7,
            ),
            SizedBox(height: 32),
            Text(
              'No Notes added \n press button "+" to add a new note ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Fredoka,',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
  }
}
