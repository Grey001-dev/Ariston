import 'package:flutter/material.dart';
class PrimaryActionButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const PrimaryActionButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF003FB1),
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 52.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
        ),
        elevation: 0,
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        )
      )
    );
  }
}