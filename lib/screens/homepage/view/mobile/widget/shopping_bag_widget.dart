import 'package:flutter/material.dart';

class ShoppingBagWidget extends StatelessWidget {
  final Color color;

  const ShoppingBagWidget({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          const SizedBox(height: 4),
          Container(
            width: 20,
            height: 3,
            decoration: BoxDecoration(
              color: color.withOpacity(0.7),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}