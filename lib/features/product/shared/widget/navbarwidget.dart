import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:roobai/app/route_names.dart';

class BottomNavBarWidget extends StatelessWidget {
  final String currentRoute;

  const BottomNavBarWidget({super.key, required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    int selectedIndex = _getSelectedIndex();

    return Container(
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        color: Colors.deepPurpleAccent,
        borderRadius: BorderRadius.circular(24), // 👈 Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
            rippleColor: Colors.deepPurple.shade50,
            hoverColor: Colors.deepPurple.shade50,
            haptic: true,
            tabBorderRadius: 16,
            curve: Curves.easeOutExpo,
            duration: const Duration(milliseconds: 500),
            gap: 6,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            tabBackgroundColor: Colors.deepPurple.shade50, 
            color: Colors.white60,
            activeColor: Colors.deepPurple,
            iconSize: 24,
            textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            tabs: const [
              GButton(
                icon: LucideIcons.house, 
                text: 'Home',

              ),
              GButton(
                icon: LucideIcons.user, // Stylish Profile
                text: 'Profile',
              ),
              GButton(
                icon: LucideIcons.tag, // Stylish Offer
                text: 'Deals',
              ),
              GButton(
                icon: LucideIcons.menu, // Stylish Menu
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
      case RouteName.setting:
        return 1;
      case RouteName.dealfinder:
        return 2;
      case RouteName.category:
        return 3;
      default:
        return 0;
    }
  }
}
