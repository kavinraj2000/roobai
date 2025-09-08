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
            'assets/animation/Cart Icon Loader.json',
            // width: 100,
            // height: 100,
            fit: BoxFit.cover,
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
