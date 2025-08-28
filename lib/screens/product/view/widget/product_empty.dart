import 'package:flutter/material.dart';
import 'package:roobai/comman/constants/app_constansts.dart';

class DealFinderEmpty extends StatelessWidget {
  const DealFinderEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.grey.shade50, Colors.grey.shade100],
        ),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text("No deals found", style: AppConstants.headerblack),
            SizedBox(height: 8),
            Text(
              "Check back later for new deals!",
              style: AppConstants.headerblack,
            ),
          ],
        ),
      ),
    );
  }
}
