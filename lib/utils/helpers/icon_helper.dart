import 'package:flutter/material.dart';

class IconHelper {
  static String iconName(IconData icon) {
    return icon.codePoint.toString();
  }

  static IconData iconFromName(String name) {
    return IconData(int.parse(name), fontFamily: 'MaterialIcons');
  }
}
