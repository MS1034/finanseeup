import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerField extends StatelessWidget {
  final controller;
  final String initialText;

  const ColorPickerField({
    super.key,
    required this.controller,
    required this.initialText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.colorController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Color',
        suffixIcon: IconButton(
          icon: const Icon(Icons.color_lens),
          onPressed: () => _showColorPicker(context, controller),
        ),
      ),
    );
  }

  void _showColorPicker(BuildContext context, controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: controller.pickerColor.value,
              onColorChanged: (Color color) {
                controller.pickerColor.value = color;
              },
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
