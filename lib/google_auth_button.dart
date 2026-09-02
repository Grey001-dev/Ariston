import 'package:flutter/material.dart';
class GoogleAuthButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const GoogleAuthButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        side: BorderSide(color: Color(0xFFD1D5DB), width: 1.5),
        minimumSize: const Size(double.infinity, 51.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        )
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Image(
            image: AssetImage('assets/images/google_logo.png'),
            width: 24.0,
            height: 24.0,
          ),
          const SizedBox(width: 12.0),
          Text(
            'Sign up with Google',
            style: TextStyle(
              color: Color(0xFF191C1E),
              fontSize: 16.0,
              fontWeight: FontWeight.w800,
            )
          ),
        ],
      ),
    );
  }
}