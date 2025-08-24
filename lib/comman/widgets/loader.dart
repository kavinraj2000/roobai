import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animation/loading.json',
              width: 100,
              height: 100,
              fit: BoxFit.contain,
            ),

            const SizedBox(height: 20),

          ],
        ),
      );
    
  }
}
