import 'package:flutter/material.dart';

Color getColorForType(String type) {
  switch (type) {
    case 'Fire':
      return Color.fromARGB(255, 230, 143, 12);
    case 'Water':
      return Color.fromARGB(255, 6, 133, 236);
    case 'Bug':
      return Colors.lightGreen;
    case 'Grass':
      return Colors.green;
    case 'Poison':
      return Colors.purple;
    case 'Electric':
      return Color.fromARGB(255, 247, 247, 23);
    case 'Ground':
      return Colors.brown;
    case 'Psychic':
      return Color.fromARGB(255, 247, 54, 118);
    default:
      return Color.fromARGB(255, 88, 99, 104);
  }
}
