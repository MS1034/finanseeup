import 'package:flutter/material.dart';

class EmailField extends StatefulWidget {
  const EmailField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.hintText,
    required this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final String? Function(String?) validator;

  @override
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
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
        prefixIcon: const Icon(Icons.email),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: widget.validator, // Apply the validator function here
    );
  }
}
