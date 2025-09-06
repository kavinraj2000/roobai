// 
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
        context.goNamed(RouteName.best);
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
      backgroundColor: Colors.white,
      selectedItemColor: Colors.deepPurple,
      unselectedItemColor: Colors.deepPurple.shade200,
      selectedLabelStyle: AppConstants.headerblack.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 13,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
      elevation: 4,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(LucideIcons.house100),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(LucideIcons.partyPopper100),
          label: 'Best',
        ),
        BottomNavigationBarItem(
          icon: Icon(LucideIcons.tag100),
          label: 'Justin',
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(LucideIcons.menu100),
        //   label: 'Category',
        // ),
      ],
    );
  }
}
