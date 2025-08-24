
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:roobai/app/route_names.dart';
import 'package:roobai/comman/constants/color_constansts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);

    // Navigate after animation completes
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed( Duration(milliseconds:10), () {
          context.pushReplacementNamed(RouteName.mainScreen);
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animation/Marketing.json',
              controller: _controller,
              height: 200,
              onLoaded: (composition) {
                _controller
                  ..duration = composition.duration
                  ..forward();
              },
            ),
            const SizedBox(height: 20),
         
             Image.asset('assets/icons/logo.png', width: 120, height: 120),
          ],
        ),
      ),
    );
  }
  
}
