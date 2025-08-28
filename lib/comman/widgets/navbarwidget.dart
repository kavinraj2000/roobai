import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:roobai/app/route_names.dart';
import 'package:roobai/comman/constants/app_constansts.dart';

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
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) => _onTabTapped(context, index),
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.deepPurpleAccent, 
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white60,
      selectedLabelStyle:  AppConstants.headerblack,
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
      elevation: 0, 
      items: const [
        BottomNavigationBarItem(
          icon: Icon(LucideIcons.house),
          label: 'Home ',
        ),
        BottomNavigationBarItem(
          icon: Icon(LucideIcons.user),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(LucideIcons.tag),
          label: 'Justin',
        ),
        BottomNavigationBarItem(
          icon: Icon(LucideIcons.partyPopper),
          label: 'Best',
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(LucideIcons.menu),
        //   label: 'Menu',
        // ),
        // BottomNavigationBarItem(
        //   icon: Icon(LucideIcons.heartHandshake),
        //   label: 'Dealfinder',
        // ),
      ],
    );
  }
}