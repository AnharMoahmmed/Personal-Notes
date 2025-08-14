import 'package:flutter/material.dart';
 

class DialogCard extends StatelessWidget {
  const DialogCard({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          width: MediaQuery.sizeOf(context).width * 0.75,
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 2, color: Colors.black),
            boxShadow: [BoxShadow(offset: Offset(2, 2))],
            borderRadius: BorderRadiusGeometry.circular(16),
          ),

          child: child,
        ),
      ),
    );
  }
}
