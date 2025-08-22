// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:roobai/app/route_names.dart';
// import 'package:roobai/core/theme/constants.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _fadeAnim;
//   late Animation<Offset> _slideAnim;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
//     _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
//     _slideAnim = Tween<Offset>(
//       begin: const Offset(0, 0.3),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

//     _controller.forward();

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Future.delayed(const Duration(seconds: 2), () {
//         if (!mounted) return;
//         context.goNamed(RouteName.mainScreen);
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: primaryColor,
//       body: Center(
//         child: FadeTransition(
//           opacity: _fadeAnim,
//           child: SlideTransition(
//             position: _slideAnim,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SizedBox(height: 24),
//                 Image.asset('assets/icons/logo.png', width: 120, height: 120),
//                 Text(
//                   'Roobai',
//                   style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 2),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   'Your ultimate shopping app',
//                   style: TextStyle(color: Colors.white70, fontSize: 16, fontStyle: FontStyle.italic),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:roobai/app/route_names.dart';
import 'package:roobai/core/theme/constants.dart';

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
      backgroundColor: primaryColor,
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
