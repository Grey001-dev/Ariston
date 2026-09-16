import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final String labelText;
  final IconData? hinticon;
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final String? helperText;

  const CustomInputField({
    this.hinticon,
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
    this.helperText,
    super.key,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  late bool _obscured = widget.isPassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: const TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          controller: widget.controller,
          obscureText: _obscured,
          decoration: InputDecoration(
            prefixIcon: widget.hinticon != null
                ? Icon(widget.hinticon, color: const Color(0xFF737686))
                : null,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      color: const Color(0xFF737686),
                    ),
                    onPressed: () => setState(() => _obscured = !_obscured),
                  )
                : null,
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              fontSize: 14.0,
              color: Color(0xFF737686),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Color(0xFFC3C5D7),
                width: 1.0,
              ),
            ),
          ),
        ),
        if (widget.helperText != null) ...[
          const SizedBox(height: 4.0),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              widget.helperText!,
              style: const TextStyle(fontSize: 10.5, color: Color(0xFFA7ABBD)),
            ),
          ),
        ],
      ],
    );
  }
}