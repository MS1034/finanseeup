import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.validator, // Make the validator optional
  });

  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final String? Function(String?)? validator; // Nullable validator

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        hintStyle:  Theme.of(context).textTheme.bodySmall, // Adjust the font size as needed

        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 0,
        ),
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
      obscureText: _obscureText,
      // keyboardType: TextInputType.visiblePassword,
      validator: widget.validator, // Apply the validator if provided
    );
  }
}
