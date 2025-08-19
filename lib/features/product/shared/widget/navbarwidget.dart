import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:roobai/app/route_names.dart';

class BottomNavBarWidget extends StatelessWidget {
  final String currentRoute;

  const BottomNavBarWidget({super.key, required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    int selectedIndex = _getSelectedIndex();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: GNav(
  selectedIndex: selectedIndex,
  onTabChange: (index) {
    switch (index) {
      case 0:
        context.goNamed(RouteName.mainScreen);
        break;
      case 1:
        context.goNamed(RouteName.setting);
        break;
      case 2:
        context.goNamed(RouteName.dealfinder);
        break;
        
      case 3:
        context.goNamed(RouteName.category); 
        break;
    }
  },
  rippleColor: Colors.transparent, // Optional: remove ripple
  hoverColor: Colors.transparent,  // Optional: remove hover effect
  haptic: true,
  tabBorderRadius: 0, // Remove rounded corners
  curve: Curves.easeOutBack,
  duration: const Duration(milliseconds: 400),
  gap: 8,
  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
  tabBackgroundColor: Colors.transparent, // Remove background
  color: Colors.grey[700],
  activeColor: Colors.deepPurple.shade700,
  iconSize: 24,
  textStyle: const TextStyle(fontWeight: FontWeight.w600),
  tabs: const [
    GButton(
      icon: Icons.home_rounded,
      text: 'Home',
    ),
    GButton(
      icon: Icons.account_circle_outlined,
      text: 'Profile',
    ),
    GButton(
      icon: Icons.local_offer_outlined,
      text: 'Dealfinder',
    ),
    GButton(
      icon: Icons.menu_rounded,
      text: 'Menu',
    ),
  ],
),

        ),
      ),
    );
  }

  int _getSelectedIndex() {
    switch (currentRoute) {
      case RouteName.mainScreen:
        return 0;
      case RouteName.mainScreen1:
        return 1;
      case RouteName.category:
        return 2;
      default:
        return 0;
    }
  }
}
