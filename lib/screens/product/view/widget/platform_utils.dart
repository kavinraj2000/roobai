import 'dart:ui';

import 'package:flutter/material.dart';

class PlatformUtils {
  static const Map<String, List<Color>> platformColors = {
    'amazon': [Color(0xFFFF9900), Color(0xFF000000)],
    'flipkart': [Color(0xFF047BD5), Color(0xFFF7A200)],
    'myntra': [Color(0xFFFF3F6C), Color(0xFF000000)],
    'default': [Colors.deepPurple, Colors.purple],
  };

  static const Map<String, IconData> platformIcons = {
    'amazon': Icons.shopping_bag,
    'flipkart': Icons.shopping_cart,
    'myntra': Icons.style,
    'default': Icons.shopping_basket,
  };
}