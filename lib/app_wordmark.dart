import 'package:flutter/material.dart';

class AppWordmark extends StatelessWidget {
  final double fontSize;
  const AppWordmark({super.key, this.fontSize = 20});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.school, color: const Color(0xFF003FB1), size: fontSize + 4),
        const SizedBox(width: 8),
        Text(
          'Ariston',
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF003FB1),
          ),
        ),
      ],
    );
  }
}