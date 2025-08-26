import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoDataWidget extends StatelessWidget {
  final String message;
  final String? lottieAssetPath;
  final double height;

  const NoDataWidget({
    super.key,
    this.message = 'No data available',
    this.lottieAssetPath = 'assets/animation/404 error page with cat.json',
    this.height = 250,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            lottieAssetPath!,
            height: height,
            fit: BoxFit.contain,
            backgroundLoading: true
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
          ),
        ],
      ),
    );
  }
}
