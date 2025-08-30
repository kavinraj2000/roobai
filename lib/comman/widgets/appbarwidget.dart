import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:roobai/app/route_names.dart';
import 'package:roobai/comman/constants/app_constansts.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final String? profileImage;
  final String? userName;
  final bool isLoggedIn; // ✅ NEW: pass login status
  final VoidCallback? onNotificationPressed;
  final VoidCallback? onProfilePressed;
  final Function(String)? onSearch;

  const CustomAppBar({
    super.key,
    this.title,
    this.profileImage,
    this.userName,
    this.isLoggedIn = false, // default false
    this.onNotificationPressed,
    this.onProfilePressed,
    this.onSearch,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 4);

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
      elevation: 2,
      titleSpacing: 0,
      leading: isSearching
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: _toggleSearch,
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Image.asset(
                'assets/icons/logo.png',
                fit: BoxFit.contain,
                height: 32,
              ),
            ),
      title: isSearching
          ? Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _searchController,
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: Colors.white70),
                ),
                onChanged: widget.onSearch,
              ),
            )
          : Text(
              widget.title ?? '',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
      actions: [
        if (!isSearching)
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: _toggleSearch,
          ),

        // ✅ If user not logged in → show "Join Us"
        if (!widget.isLoggedIn)
          TextButton(
            onPressed: () => context.goNamed(RouteName.joinUs),
            child: const Text(
              'Join Us',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
                letterSpacing: 0.5,
              ),
            ),
          ),

        IconButton(
          icon: const Icon(Icons.notifications, color: Colors.white),
          onPressed: widget.onNotificationPressed,
        ),

        if (widget.isLoggedIn)
          GestureDetector(
            onTap: widget.onProfilePressed,
            child: Padding(
              padding: const EdgeInsets.only(right: 14),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                backgroundImage: widget.profileImage != null
                    ? NetworkImage(widget.profileImage!)
                    : null,
                child: widget.profileImage == null
                    ? const Icon(Icons.person, color: Color(0xFF5E17EB))
                    : null,
              ),
            ),
          ),
      ],
    );
  }
}
