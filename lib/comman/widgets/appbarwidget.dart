import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:roobai/app/route_names.dart';
import 'package:roobai/comman/constants/app_constansts.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final String? profileImage;
  final String? userName;
  final VoidCallback? onNotificationPressed;
  final VoidCallback? onProfilePressed;
  final Function(String)? onSearch;

  const CustomAppBar({
    super.key,
    this.title,
    this.profileImage,
    this.userName,
    this.onNotificationPressed,
    this.onProfilePressed,
    this.onSearch,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  void _toggleSearch() {
    setState(() {
      isSearching = !isSearching;
      if (!isSearching) _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF5E17EB),
      elevation: 0,
      leading: isSearching
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: _toggleSearch,
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/icons/logo.png', fit: BoxFit.contain),
            ),
      // title: isSearching
      //     ? TextField(
      //         controller: _searchController,
      //         autofocus: true,
      //         style: const TextStyle(color: Colors.white),
      //         cursorColor: Colors.white,
      //         decoration: const InputDecoration(
      //           hintText: 'Search...',
      //           hintStyle: TextStyle(color: Colors.white70),
      //           border: InputBorder.none,
      //         ),
      //         onChanged: widget.onSearch,
      //       )
      //     : Text(
      //         widget.title ?? '',
      //         style: const TextStyle(
      //           color: Colors.white,
      //           fontWeight: FontWeight.w600,
      //         ),
      //       ),
      // actions: isSearching
      //     ? [
      //         IconButton(
      //           icon: const Icon(Icons.close, color: Colors.white),
      //           onPressed: _toggleSearch,
      //         ),
      //       ]
          actions:  [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: (){
                  context.goNamed(RouteName.search);
                },
              ),
              TextButton(
                onPressed: () {
                  context.goNamed(RouteName.joinUs);
                },
                child: const Text(
                  'Join us',
                  style: AppConstants.headerwhite
                ),
              ),
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.white),
                onPressed: widget.onNotificationPressed,
              ),
              GestureDetector(
                onTap: widget.onProfilePressed,
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: const Icon(Icons.person, color: Colors.white),
                ),
              ),
          ]      
    );
  }
}
