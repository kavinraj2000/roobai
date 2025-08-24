import 'package:flutter/material.dart';
import 'package:roobai/comman/widgets/loader.dart';

class DealFinderLoading extends StatelessWidget {
  const DealFinderLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue.shade50, Colors.purple.shade50],
        ),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(child: LoadingPage()),
            SizedBox(height: 16),
            Text(
              "Finding amazing deals...",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.deepPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}