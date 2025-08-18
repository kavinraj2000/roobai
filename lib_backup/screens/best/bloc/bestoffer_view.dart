// import 'package:flutter/material.dart';
// import 'package:roobai_app/features/product/shared/widget/appbarwidget.dart';
// import 'package:roobai_app/features/product/shared/widget/navbarwidget.dart';

// class Bestoffer extends StatelessWidget{
//   const Bestoffer({super.key});

//   @override
//   Widget build(BuildContext context) {
    
//   final List<FancyNavbarItem> _navbarItems = [
//     FancyNavbarItem(icon:Icons.home, tooltip: 'Home'),
//     FancyNavbarItem(icon:Icons.local_offer_outlined, tooltip: 'best'),
//     FancyNavbarItem(icon: Icons.menu_rounded, tooltip: 'Categories'),
//     FancyNavbarItem(icon: Icons.favorite, tooltip: 'Favorites'),
//     FancyNavbarItem(icon: Icons.person, tooltip: 'Profile'),
//   ];
//     return Scaffold(
//       appBar: Appbarwidget(),
//        bottomNavigationBar: FancyNavbar(
//         selectedIndex: _selectedIndex,
//         onItemSelected: _onItemTapped,
//         items: _navbarItems,
//         activeColor: Colors.white,
//         inactiveColor: Colors.grey,
//         backgroundColor: Colors.black,
//       ),

//     )
//   }

// }