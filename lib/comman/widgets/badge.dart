import 'package:flutter/material.dart';
import 'package:roobai/comman/constants/app_constansts.dart';

class ExpiredOrGoatBadge extends StatelessWidget {
  final bool isExpired;
  final int discount;

  const ExpiredOrGoatBadge({
    super.key,
    required this.isExpired,
    required this.discount,
  });

  @override
  Widget build(BuildContext context) {
    if (isExpired) {
      return _buildBadge("Expired", Colors.red);
    }
    if (discount >= 80) {
      return _buildBadge("G.O.A.T", Colors.deepPurple);
    }
    return const SizedBox.shrink();
  }

Widget _buildBadge(String text, Color color) {
  return Container(
    // width: double.infinity,

    decoration: BoxDecoration(
      color: color,
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(8),
        bottomRight: Radius.circular(8),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.25),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    alignment: Alignment.center,
    child: Text(text, style: AppConstants.headerwhite),
  );
}

  
}
