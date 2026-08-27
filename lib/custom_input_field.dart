import 'package:flutter/material.dart';
class CustomInputField extends StatelessWidget {
  final String labelText;
  final IconData hinticon;
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;

  const CustomInputField({
    required this.hinticon,
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          )
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            prefixIcon: Icon(hinticon, color: Color(0xFF737686)),
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 16.0,
              color: Color(0xFF737686),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: Color(0xFFC3C5D7),
                width: 1.0,
              )
            )
          )
        )
      ]
    );
  }
}