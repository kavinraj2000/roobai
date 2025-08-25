import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:roobai/app/route_names.dart';

class BottomNavBarWidget extends StatelessWidget {
  final int selectedIndex;

  const BottomNavBarWidget({
    super.key,
    required this.selectedIndex,
  });

  void _onTabTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.goNamed(RouteName.mainScreen);
        break;
      case 1:
        context.goNamed(RouteName.setting);
        break;
      case 2:
        context.goNamed(RouteName.product);
        break;
      case 3:
        context.goNamed(RouteName.category);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16), 
      child: Material(
        color: Colors.deepPurpleAccent,
        borderRadius: BorderRadius.circular(20),
        elevation: 6,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) => _onTabTapped(context, index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent, // ✅ transparent background
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white60,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
          elevation: 0, // ✅ remove elevation so no shadow from bar itself
          items: const [
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.house),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.user),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.tag),
              label: 'Deals',
            ),
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.menu),
              label: 'Menu',
            ),
          ],
        ),
      ),
    );
  }
}
