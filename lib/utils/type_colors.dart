import 'package:flutter/material.dart';

class TypeColors {
  static const Map<String, Color> colors = {
    'Fire': Color(0xFFFF6B35),
    'Water': Color(0xFF4A9EFF),
    'Grass': Color(0xFF4CAF50),
    'Electric': Color(0xFFFFD600),
    'Poison': Color(0xFF9C27B0),
    'Flying': Color(0xFF81D4FA),
    'Ghost': Color(0xFF7B1FA2),
    'Dragon': Color(0xFF1565C0),
    'Dark': Color(0xFF37474F),
    'Steel': Color(0xFF90A4AE),
    'Fighting': Color(0xFFE53935),
    'Psychic': Color(0xFFE91E63),
    'Rock': Color(0xFF8D6E63),
    'Normal': Color(0xFF9E9E9E),
    'Ice': Color(0xFF80DEEA),
    'Bug': Color(0xFF8BC34A),
    'Fairy': Color(0xFFF48FB1),
    'Ground': Color(0xFFD7CCC8),
  };

  static Color getColor(String type) {
    return colors[type] ?? const Color(0xFF9E9E9E);
  }

  static List<Color> getGradient(List<String> types) {
    if (types.length == 1) {
      final base = getColor(types[0]);
      return [base, base.withOpacity(0.6)];
    }
    return [getColor(types[0]), getColor(types[1])];
  }
}