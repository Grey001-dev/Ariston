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
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF003FB1),
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 51.0),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            padding: const EdgeInsets.all(3),
            child: Image.asset(
              'assets/images/google_logo.png',
              // Falls back gracefully if the asset isn't wired up yet,
              // so the layout never breaks during development.
              errorBuilder: (context, error, stackTrace) => const Text(
                'G',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: Color(0xFF003FB1), height: 1.1),
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          Flexible(
            child: Text(
              buttonText,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}